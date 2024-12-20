import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mimo/models/categories_model.dart';
import 'package:mimo/models/tasks_model.dart';

class TodoController extends GetxController {
  final categories = <CategoriesModel>[].obs;
  var tasks = <TaskModel>[].obs;

  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
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
  }

  void addTask(String categoryId, String title, DateTime dueDate) {
    final newTask = TaskModel(title: title, dueDate: dueDate);

    // Update Firestore
    FirebaseFirestore.instance.collection('categories').doc(categoryId).update({
      'tasks': FieldValue.arrayUnion([newTask.toMap()]),
    }).then((_) {
      // Update local task list in the controller
      tasks.add(newTask);
    });
  }

  void setTasks(List<TaskModel> newTasks) {
    tasks.value = newTasks;
  }

  void toggleTaskCompletion(TaskModel task, String categoryId) {
    task.isCompleted = !task.isCompleted;
    update();
  }
}
