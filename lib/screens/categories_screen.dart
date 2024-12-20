import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mimo/controllers/theme_controller.dart';
import 'package:mimo/screens/tasks_screen.dart';
import 'package:mimo/widgets/add_categories_card.dart';
import 'package:mimo/widgets/categories_card.dart';
import '../controllers/todo_controller.dart';
import '../utils/responsive_helper.dart';

class CategoriesScreen extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());
  final ThemeController themeController = Get.put(ThemeController());
  final TextEditingController _searchController = TextEditingController();
  var _isSearching = false.obs;

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
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/settings');
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/27837583/pexels-photo-27837583/free-photo-of-smile.jpeg?auto=compress&cs=tinysrgb&w=600'),
            ),
          ),
        ),
        title: Obx(() => _isSearching.value
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search categories...',
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  controller.updateSearchQuery(text); 
                },
              )
            : const Text('Categories')),
        actions: [
          IconButton(
            icon: Obx(() => Icon(_isSearching.value ? Icons.cancel : Icons.search)),
            onPressed: () {
              _isSearching.value = !_isSearching.value;
              if (!_isSearching.value) {
                _searchController.clear();
                controller.updateSearchQuery('');
              }
            },
          ),
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
              child: const ListTile(
                title: Text('"The memories is a shield and life helper."'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlNe15G2SbJ39SNGlc2tSCJfniJmmwo8M78lweoU6l_MGMhAQ6yRZ9LXSIU8BtXxnjw86pPhzBE5JsXZAmlbeRag'),
                ),
                subtitle: Text(
                  'Tamim al-Barghouti',
                  style: TextStyle(),
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.screenHeight(context) * 0.030,
            ),
            Expanded(
              child: Obx(() {
                final query = controller.searchQuery.value.toLowerCase();
                final filteredCategories = controller.categories
                    .where((category) =>
                        category.name?.toLowerCase().contains(query) ?? false)
                    .toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemCount: filteredCategories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AddCategoriesCard(controller: controller);
                    }
                    final category = filteredCategories[index - 1];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddTasksScreen(category: category),
                          ),
                        );
                      },
                      child: CategoriesCard(categories: category),
                    );
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
