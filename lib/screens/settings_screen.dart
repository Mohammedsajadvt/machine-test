import 'package:flutter/material.dart';
import 'package:mimo/models/menu_model.dart';
import 'package:mimo/utils/responsive_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = [
      MenuModel(icon: Icon(Icons.notifications), title: 'Notifications'),
      MenuModel(icon: Icon(Icons.settings), title: 'General'),
      MenuModel(icon: Icon(Icons.person), title: 'Account'),
      MenuModel(icon: Icon(Icons.info), title: 'About'),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: ResponsiveHelper.screenWidth(context) * 0.040,
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://images.pexels.com/photos/27837583/pexels-photo-27837583/free-photo-of-smile.jpeg?auto=compress&cs=tinysrgb&w=600'),
              ),
              title: Text(
                'Malak Idrissi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Rabat, Morocco'),
              trailing: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.040),
            Padding(
              padding: EdgeInsets.only(
                right: ResponsiveHelper.screenWidth(context) * 0.050,
                left: ResponsiveHelper.screenWidth(context) * 0.050,
              ),
              child: Row(
                children: [
                  Expanded(child: Text("Hi! My name is Malak, I'm a community manager from Rabat, Morocco"))
                ],
              ),
            ),
            SizedBox(height: ResponsiveHelper.screenHeight(context) * 0.080),
            Expanded(
              child: ListView.builder(
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  final data = menu[index];
                  return ListTile(
                    leading: data.icon,
                    title: Text(data.title,style: TextStyle(fontWeight: FontWeight.bold),),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
