import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mimo/models/categories_model.dart';
import 'package:mimo/models/tasks_model.dart';

class TodoController extends GetxController {
  final categories = <CategoriesModel>[].obs;
  var tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }
 

   RxString searchQuery = ''.obs; 

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
    FirebaseFirestore.instance.collection('categories').doc(categoryId).update({
      'tasks': FieldValue.arrayUnion(
          [TaskModel(title: title, dueDate: dueDate).toMap()]),
    }).then((_) {
      fetchCategories();
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
