import 'package:flutter/material.dart';
import 'package:myfirstapp/models/type_card.dart';

import 'type_tile.dart';

class MyCategories extends StatefulWidget {
  const MyCategories({super.key});

  @override
  State<MyCategories> createState() => _MyCategoriesState();
}

class _MyCategoriesState extends State<MyCategories> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100, // กำหนดความสูงให้กับ ListView เพื่อไม่ให้ Expanded เกิด error
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: typeImages.length,
              itemBuilder: (context, index) {
                TypeModel type = typeImages[index];
                return TypeTile(type: type);
              },
            ),
          ),
        ],
      ),
    );
  }
}

