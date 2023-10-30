import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black87
            ),
            accountName: Text("Doni Pizza"),
            accountEmail: Text("donipizza@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
            },
          ),
          // Add more menu items as needed
        ],
      ),
    );
  }
}
