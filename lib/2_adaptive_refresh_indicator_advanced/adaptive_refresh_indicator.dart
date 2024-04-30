import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveRefreshIdicator2 extends StatelessWidget {
  final Widget? child;
  final List<Widget>? slivers;
  final Future<void> Function() onRefresh;

  const AdaptiveRefreshIdicator2({
    super.key,
    this.child,
    this.slivers,
    required this.onRefresh,
  }) : assert((slivers != null) != (child != null));

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _SliverAdaptiveRefreshIdicator(
        onRefresh: onRefresh,
        key: key,
        slivers: slivers,
        child: child,
      );
    }

    return _AndroidAdaptiveRefreshIdicator(
      onRefresh: onRefresh,
      key: key,
      slivers: slivers,
      child: child,
    );
  }
}

class _AndroidAdaptiveRefreshIdicator extends StatelessWidget {
  final Widget? child;
  final List<Widget>? slivers;
  final Future<void> Function() onRefresh;

  const _AndroidAdaptiveRefreshIdicator({
    super.key,
    this.child,
    this.slivers,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final content = slivers != null
        ? _SliverAdaptiveRefreshIdicator(
            onRefresh: onRefresh,
            key: key,
            slivers: slivers,
            isCupertinoSliverRefreshControlShown: false,
            child: child,
          )
        : SingleChildScrollView(child: child);

    return RefreshIndicator(onRefresh: onRefresh, child: content);
  }
}

class _SliverAdaptiveRefreshIdicator extends StatelessWidget {
  final Widget? child;
  final Future<void> Function() onRefresh;
  final List<Widget>? slivers;
  final bool isCupertinoSliverRefreshControlShown;

  const _SliverAdaptiveRefreshIdicator({
    super.key,
    this.slivers,
    this.child,
    this.isCupertinoSliverRefreshControlShown = true,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: isCupertinoSliverRefreshControlShown
          ? const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            )
          : null,
      slivers: [
        if (isCupertinoSliverRefreshControlShown)
          SliverSafeArea(
            sliver: CupertinoSliverRefreshControl(
              onRefresh: onRefresh,
            ),
          ),
        ...?slivers,
        if (child != null)
          SliverToBoxAdapter(
            child: child,
          )
      ],
    );
  }
}
