import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mimo/models/categories_model.dart';
import 'package:mimo/models/tasks_model.dart';

class TodoController extends GetxController {
  final categories = <CategoriesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() {
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((snapshot) {
      categories.value = snapshot.docs
          .map((doc) => CategoriesModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  void addCategories(String name, String emoji, String task) {
    FirebaseFirestore.instance.collection('categories').add({
      'name': name,
      'task': task,
      'emoji': emoji,
    }).then((_) {
      fetchCategories();
    });
    print("Categories added: $name, $emoji, $task");
  }

  void addTask(String categoryId, String title, DateTime dueDate) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId)
        .update({
      'tasks': FieldValue.arrayUnion([
        TaskModel(title: title, dueDate: dueDate).toMap()
      ]),
    }).then((_) {
      fetchCategories();
    });
    print("Task added: $title, $dueDate to category $categoryId");
  }
}
