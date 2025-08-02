import 'package:flutter/material.dart';

class SeeAllScreen<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  const SeeAllScreen({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: items.isEmpty
            ? const Center(child: Text("No items available"))
            : ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return itemBuilder(item);
                },
              ),
      ),
    );
  }
}
