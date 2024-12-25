import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {"count": 10, "label": "ประเภทสินค้า", "onTap": () => print("ประเภทสินค้า")},
    {"count": 25, "label": "รายการสินค้า", "onTap": () => print("รายการสินค้า")},
    {"count": 5, "label": "หมวดหมู่", "onTap": () => print("หมวดหมู่")},
    {"count": 50, "label": "สินค้าที่ถูกสั่งซื้อ", "onTap": () => print("สินค้าที่ถูกสั่งซื้อ")},
    {"count": 100, "label": "จำนวนผู้ใช้งาน", "onTap": () => print("จำนวนผู้ใช้งาน")},
    {"count": 5000, "label": "รายได้", "onTap": () => print("รายได้")},
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // ชิดกรอบบน
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0), // Padding รอบๆ กลุ่มเมนู
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          alignment: WrapAlignment.start,
          children: menuItems.map((item) {
            return MenuBox(
              count: item['count'],
              label: item['label'],
              onTap: item['onTap'],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MenuBox extends StatelessWidget {
  final int count;
  final String label;
  final VoidCallback onTap;

  const MenuBox({
    required this.count,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        constraints: const BoxConstraints(maxWidth: 350),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4.0,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
