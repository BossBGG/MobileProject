import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/stock.dart';
import 'item_tile.dart';

class PromotionTile extends StatelessWidget {
  final Stock stock = Stock();

  PromotionTile({super.key});

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
                'Promotion',
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
            height: 250, // กำหนดความสูงให้กับ ListView ให้พอดีกับ ItemTile ใหม่
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stock.promotionItems.length,
              itemBuilder: (context, index) {
                Shirt shirt = stock.promotionItems[index];
                return ItemTile(shirt: shirt);
              },
            ),
          ),
        ],
      ),
    );
  }
}
