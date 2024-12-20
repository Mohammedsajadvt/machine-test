
import 'package:flutter/material.dart';
import 'package:mimo/models/categories_model.dart';

class CategoriesCard extends StatelessWidget {
  final CategoriesModel categories;
  const CategoriesCard({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(categories.emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8.0),
          Text(categories.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          Text(categories.task, style: const TextStyle(color: Colors.grey)),
          
        ],
      ),
    );
  }
}
