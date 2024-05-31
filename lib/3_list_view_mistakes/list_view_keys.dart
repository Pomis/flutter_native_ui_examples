import 'package:flutter/material.dart';

class ListViewKeys extends StatelessWidget {
  const ListViewKeys({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView keys")),
      body: ListView.builder(
        itemCount: 200,
        prototypeItem: const _ListItem(null),
        itemBuilder: (context, index) {
          if (index == 199) {
            return const _ListItem(199, key: ValueKey("last_item"));
          }

          return _ListItem(index);
          
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
