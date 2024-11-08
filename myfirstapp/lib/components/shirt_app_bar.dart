import 'package:flutter/material.dart';
import 'package:myfirstapp/page/cart_page.dart';

class ShirtAppBar extends StatelessWidget {
  const ShirtAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey.shade100,
      pinned: true,
      // เปลี่ยนเป็น IconButton สำหรับ back อยู่ทางซ้าย
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context); // กลับไปยังหน้าเดิมเมื่อกดปุ่ม back
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: [
        // นำไอคอน search และ home มาอยู่ด้านขวา
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.search_rounded),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context , 
            MaterialPageRoute(
              builder:(context) => CartPage(),)
            );
          }, 
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
      ],
    );
  }
}