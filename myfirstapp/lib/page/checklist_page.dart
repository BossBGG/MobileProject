import 'package:flutter/material.dart';
import 'package:myfirstapp/components/cart_tile.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/models/cart.dart';
import 'package:myfirstapp/components/my_button.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar:  AppBar(
        title: Text("รายการสินค้าที่สั่งซื้อ"),
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80), // เว้นที่สำหรับแถบล่าง
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final cartItem = cart.items[index];
                return MyCartTile(
                  cartItem: cartItem,
                  removeButtons: true, // ไม่แสดงปุ่มเพิ่ม/ลด และปุ่มลบ
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              
              child: Column(
                
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: Colors.grey, thickness: 5,height: 20,),

                  // ราคาสินค้ารวม
                  Text("ราคาสินค้ารวม: \$${cart.totalCartPrice.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  // ค่าขนส่ง
                  const Text("ค่าขนส่ง: \$100.00",style: TextStyle(fontSize: 20)),

                  // ช่องว่างเพิ่มระหว่างค่าขนส่งและราคารวมทั้งหมด
                  const SizedBox(height: 8),

                  // ราคารวมทั้งหมด
                  Text(
                    "ราคารวมทั้งหมด: \$${(cart.totalCartPrice + 100).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  
                  const SizedBox(height: 15),

                  MyButton(
                    onTap: () {
                      // เพิ่มฟังก์ชันการชำระเงินที่นี่
                    },
                    text: "ชำระเงิน",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
