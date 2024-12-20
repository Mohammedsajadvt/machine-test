import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mimo/models/categories_model.dart';

class TodoController extends GetxController {
  final categories = < CategoriesModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  //FetchTasks
  void fetchTasks() {
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((snapshot) {
      categories.value = snapshot.docs
          .map((doc) => CategoriesModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // AddNewTask
 void addTask(String name, String emoji, String task) {
  FirebaseFirestore.instance.collection('categories').add({
    'name': name,
    'task': task,
    'emoji': emoji,
  }).then((_) {
    fetchTasks();  
  });
  print("Categories added: $name, $emoji, $task");
}



}
