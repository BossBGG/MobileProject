import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // ทำให้เนื้อหากลาง
        children: [

          // Home
          MyDrawerTile(
            text: "Home", 
            onTap: () => Navigator.pop(context),
          ),
          
          SizedBox(height: 1),

          // MyCart
          MyDrawerTile(
            text: "MyCart", 
            onTap: () => Navigator.pop(context),
          ),

          SizedBox(height: 1),

          // Favorite
          MyDrawerTile(
            text: "Favorite", 
            onTap: () => Navigator.pop(context),
          ),

          SizedBox(height: 1),

          // My Orders
          MyDrawerTile(
            text: "My Orders", 
            onTap: () => Navigator.pop(context),
          ),

          MyDrawerTile(
            text: "Admin", 
            onTap: () => Navigator.pop(context),
          ),

          SizedBox(height: 8),

          // Log out with red text color
          MyDrawerTile(
            text: "Log out", 
            onTap: () {},
            textColor: Colors.red, // กำหนดสีแดงให้ Log out
          ),
        ],
      ),
    );
  }
}
