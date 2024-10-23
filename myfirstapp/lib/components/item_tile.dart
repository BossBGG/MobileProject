import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemTile extends StatelessWidget {
  final Shirt shirt;

  const ItemTile({super.key, required this.shirt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5), // ปรับระยะห่างระหว่างแต่ละ Container
      height: 250, // ปรับความสูงของ Container ให้เหมาะสม
      width: 140, // ปรับความกว้างของ Container ให้เหมาะสมกับรูปภาพ
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              shirt.imagePath[0], // เข้าถึงภาพแรกจาก List<String>
              fit: BoxFit.cover,
              width: 140,
              height: 180, // ปรับความสูงของรูปภาพให้เหมาะสมกับ Container
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "\$${shirt.price.toString()}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            shirt.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }  
}
