import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TapArea2 extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongTap;
  final double borderRadius;
  final EdgeInsets? padding;
  final TapAreaStyle? style;

  const TapArea2({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongTap,
    this.style,
    this.padding,
    this.borderRadius = 0,
  });

  @override
  // ignore: no_logic_in_create_state
  State<TapArea2> createState() => switch(defaultTargetPlatform) {
    TargetPlatform.android => _TapAreaAndroidState(),
    TargetPlatform.iOS => _TapAreaIosState(),
    _ => _TapAreaWebState()
  };
}

class _TapAreaAndroidState extends State<TapArea2> {
  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.child,
    );

    if (widget.onTap == null && widget.onLongTap == null) return content;

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        onTap: widget.onTap,
        onLongPress: widget.onLongTap,
        child: content,
      ),
    );
  }
}

class _TapAreaIosState extends State<TapArea2> {
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.child,
    );

    if (widget.onTap == null && widget.onLongTap == null) return content;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isDown = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isDown = false;
        });
      },
      onTap: () {
        setState(() {
          _isDown = false;
        });
        widget.onTap!();
      },
      onLongPress: widget.onLongTap,
      child: Focus(
        child: Opacity(
          opacity: _isDown ? 0.7 : 1.0,
          child: content,
        ),
      ),
    );
  }
}

class _TapAreaWebState extends State<TapArea2> {
  final _statesController = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.child,
    );

    if (widget.onTap == null && widget.onLongTap == null) return content;

    return ListenableBuilder(
        listenable: _statesController,
        builder: (context, _) {
          final resolvedOpacity =
              widget.style?.opacity.resolve(_statesController.value) ?? 1.0;
          final resolvedHighlightOpacity = widget.style?.foregroundHighlight
                  .resolve(_statesController.value) ??
              1.0;

          return MouseRegion(
            onEnter: (_) {
              _statesController.update(WidgetState.hovered, true);
            },
            onExit: (_) {
              _statesController.update(WidgetState.hovered, false);
            },
            child: GestureDetector(
              onTapDown: (_) {
                _statesController.update(WidgetState.pressed, true);
              },
              onTapCancel: () {
                _statesController.update(WidgetState.pressed, false);
              },
              onTap: () {
                _statesController.update(WidgetState.pressed, false);

                widget.onTap!();
              },
              onLongPress: widget.onLongTap,
              child: Focus(
                child: ColoredBox(
                  color:
                      Colors.deepPurple.withOpacity(resolvedHighlightOpacity),
                  child: Opacity(
                    opacity: resolvedOpacity,
                    child: content,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class TapAreaThemeData {
  final TapAreaStyle style;

  TapAreaThemeData(this.style);
}

class TapAreaStyle {
  final WidgetStateProperty<double?> opacity;
  final WidgetStateProperty<double?> foregroundHighlight;

  TapAreaStyle({required this.opacity, required this.foregroundHighlight});
}
