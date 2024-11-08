import 'package:flutter/material.dart';


class SelectAddressBar extends StatelessWidget {
  const SelectAddressBar({super.key});

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
    );;
  }
}
