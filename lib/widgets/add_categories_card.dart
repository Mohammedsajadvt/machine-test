import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/controllers/todo_controller.dart';
import 'package:mimo/utils/responsive_helper.dart';

class AddCategoriesCard extends StatelessWidget {
  final TodoController controller;
  const AddCategoriesCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emojiController = TextEditingController();
    final TextEditingController taskController = TextEditingController();

    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          content: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(ResponsiveHelper.screenHeight(context) * 0.016),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: emojiController,
                      decoration: const InputDecoration(
                        labelText: 'Emoji',
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: taskController,
                      decoration: const InputDecoration(labelText: '0 task (optional)'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.016),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        const Text('Cancel',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty && emojiController.text.isNotEmpty) {
                        controller.addCategories(
                          nameController.text,
                          emojiController.text,
                          taskController.text.isEmpty ? '0 task' : taskController.text,
                        );
                        Get.back();
                      }
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Add Task',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      child: Card(
        child:  Center(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: themeController.isDarkMode.value?Colors.white:Colors.black,
            child: Center(
              child: Icon(Icons.add, size: 30,color: themeController.isDarkMode.value?Colors.blueAccent:Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
