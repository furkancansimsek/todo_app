import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 32,
              ),
            ),
            accountName: Text('Furkan'),
            accountEmail: Text('admin@admin.com'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {Get.to(() => HomeScreen())},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Quit'),
            onTap: () => {SystemNavigator.pop(animated: true)},
          ),
        ],
      ),
    );
  }
}
