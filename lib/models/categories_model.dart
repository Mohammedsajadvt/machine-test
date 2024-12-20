class CategoriesModel {
  String id;
  String name;
  String task;
  String emoji;

   CategoriesModel({required this.id, required this.name, required this.task, required this.emoji});

  factory  CategoriesModel.fromMap(Map<String, dynamic> data, String id) {
    return  CategoriesModel(
      id: id,
      name: data['name'],
      task: data['task'], 
      emoji: data['emoji'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'task': task,  
      'emoji': emoji,
    };
  }
}
