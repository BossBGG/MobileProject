import 'package:flutter/material.dart';
import 'package:myfirstapp/page/featured_page.dart';
import 'package:myfirstapp/page/shirt_page.dart';
import '../models/item.dart';
import '../models/stock.dart';
import 'item_tile.dart';

class FeaturedTile extends StatelessWidget {
  final Stock stock = Stock();

  FeaturedTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeaturedPage()),
                  );
                },
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
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stock.featuredItems.length,
              itemBuilder: (context, index) {
                Shirt shirt = stock.featuredItems[index];
                return GestureDetector(
                  onTap: () {
                    // เมื่อกดที่ ItemTile จะไปยัง ShirtPage พร้อมข้อมูลของเสื้อตัวที่เลือก
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShirtPage(shirt: shirt), // ส่งข้อมูล Shirt ไปยังหน้า ShirtPage
                      ),
                    );
                  },
                  child: ItemTile(shirt: shirt),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
