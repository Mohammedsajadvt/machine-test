import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/widgets/add_categories_card.dart';
import 'package:mimo/widgets/categories_card.dart';
import '../controllers/todo_controller.dart';
import '../utils/responsive_helper.dart';

class CategoriesScreen extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(
            left: ResponsiveHelper.screenHeight(context) * 0.012,
          ),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/27837583/pexels-photo-27837583/free-photo-of-smile.jpeg?auto=compress&cs=tinysrgb&w=600'),
          ),
        ),
        title: const Text('Categories'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: ResponsiveHelper.screenHeight(context) * 0.012,
          right: ResponsiveHelper.screenHeight(context) * 0.012,
          top: ResponsiveHelper.screenHeight(context) * 0.040,
        ),
        child: Column(
          children: [
            Card(
              color: const Color(0xffF9F9F9),
              child: const ListTile(
                title: Text('"The memories is a shield and life helper."'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlNe15G2SbJ39SNGlc2tSCJfniJmmwo8M78lweoU6l_MGMhAQ6yRZ9LXSIU8BtXxnjw86pPhzBE5JsXZAmlbeRag'),
                ),
                subtitle: Text(
                  'Tamim al-Barghouti',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.screenHeight(context) * 0.030,
            ),
            Expanded(
              child: Obx(() {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: controller.categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AddCategoriesCard(controller: controller);
                    }
                    final category = controller.categories[index - 1];
                    return CategoriesCard(categories: category,);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
