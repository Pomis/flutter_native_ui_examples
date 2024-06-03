import 'package:flutter/material.dart';

final _globalKeys = List.generate(200, (_) => GlobalKey());

class ListViewKeys extends StatelessWidget {
  final bool useGlobalKeys;
  final bool useValueKeys;

  const ListViewKeys._({super.key, required this.useGlobalKeys, required this.useValueKeys});

  factory ListViewKeys.globalKeys() {
    return const ListViewKeys._(useGlobalKeys: true, useValueKeys: false);
  }

  factory ListViewKeys.valueKeys() {
    return const ListViewKeys._(useGlobalKeys: false, useValueKeys: true);
  }

  factory ListViewKeys.noKeys() {
    return const ListViewKeys._(useGlobalKeys: false, useValueKeys: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView keys")),
      body: ListView.builder(
        restorationId: 'news_feed',
        itemCount: 200,
        prototypeItem: const _ListItem(null),
        itemBuilder: (context, index) {
          if (index == 199) {
            return const _ListItem(199, key: ValueKey("last_item"));
          }
          final key = useGlobalKeys ? _globalKeys[index] : useValueKeys ? ValueKey("item_$index") : null;
          
          return _ListItem(index, key: key);
        },
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final int? index;

  const _ListItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.blueAccent.withOpacity(0.2),
      child: ListTile(
        leading: Image.network("https://external-preview.redd.it/searching-for-flutter-jobs-in-nutshell-v0-9IzaY9JP5-j2YRSPe6FZnaQthG7qpDOn3FgFrp6cy6A.jpg?auto=webp&s=44254c56bbd2555a63ae41f5e3a5729db431bff6"),
        title: Text("Item $index"),
        subtitle: const Text("Subtitle"),
        trailing: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
