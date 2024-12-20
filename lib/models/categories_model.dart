import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimo/models/tasks_model.dart';

class CategoriesModel {
  String id;
  String name;
  String emoji;
  List<TaskModel> tasks;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.emoji,
    this.tasks = const [],
  });

  factory CategoriesModel.fromMap(Map<String, dynamic> data, String id) {
    return CategoriesModel(
      id: id,
      name: data['name'],
      emoji: data['emoji'] ?? '',
      tasks: (data['tasks'] as List<dynamic>?)
              ?.map((task) => TaskModel.fromMap(task))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'emoji': emoji,
      'tasks': tasks.map((task) => task.toMap()).toList(),
    };
  }
}
