import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/controllers/todo_controller.dart';
import 'package:mimo/models/categories_model.dart';
import 'package:intl/intl.dart';
import 'package:mimo/models/tasks_model.dart';

class AddTasksScreen extends StatelessWidget {
  final CategoriesModel category;
  final TodoController todoController = Get.put(TodoController());

  AddTasksScreen({super.key, required this.category});

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final ThemeController themeController = Get.find();

  List<TaskModel> _filterTasks(String query) {
    return category.tasks.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  List<TaskModel> _getTasksForDate(DateTime date) {
    return _filterTasks(_searchController.text).where((task) {
      return task.dueDate.year == date.year &&
          task.dueDate.month == date.month &&
          task.dueDate.day == date.day;
    }).toList();
  }

  List<TaskModel> _getRemainingTasks() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return _filterTasks(_searchController.text).where((task) {
      return task.dueDate.isAfter(tomorrow);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    todoController.setTasks(category.tasks);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  (context as Element).markNeedsBuild();
                },
              )
            : Text(category.name),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              if (_isSearching) {
                _searchController.clear();
                _isSearching = false;
              } else {
                _isSearching = true;
              }
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: themeController.isDarkMode.value?Colors.white:Colors.black,
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child:  Icon(Icons.add,color: themeController.isDarkMode.value?Colors.blueAccent:Colors.black),
      ),
      body: GetBuilder<TodoController>(
        builder: (controller) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_getTasksForDate(DateTime.now()).isNotEmpty)
                _buildTaskSection("Today", _getTasksForDate(DateTime.now())),
              if (_getTasksForDate(DateTime.now().add(const Duration(days: 1)))
                  .isNotEmpty)
                _buildTaskSection(
                    "Tomorrow",
                    _getTasksForDate(
                        DateTime.now().add(const Duration(days: 1)))),
              if (_getRemainingTasks().isNotEmpty)
                _buildTaskSection("Upcoming", _getRemainingTasks()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTaskSection(String title, List<TaskModel> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...tasks.map((task) => ListTile(
              leading: Icon(
                task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: task.isCompleted ? Colors.green : Colors.grey,
              ),
              title: Text(task.title),
              subtitle: Text(
                "Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate)}",
              ),
              onTap: () {
                todoController.toggleTaskCompletion(task, category.id);
              },
            )),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Task Title"),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    selectedDate != null
                        ? "Due Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}"
                        : "Pick a Due Date",
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        selectedDate = pickedDate;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  todoController.setTasks([...todoController.tasks]);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
