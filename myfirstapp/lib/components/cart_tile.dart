import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_quantity_selector.dart';
import 'package:provider/provider.dart';
import 'package:myfirstapp/models/cart.dart';
import 'package:myfirstapp/models/cart_item.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  final bool removeButtons; // กำหนดให้สามารถซ่อนปุ่มได้

  const MyCartTile({
    super.key,
    required this.cartItem,
    this.removeButtons = true, // ค่าเริ่มต้นแสดงปุ่ม
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 1),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          cartItem.shirt.imagePath[0],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.shirt.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                if (cartItem.shirt.promotion != null)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '\$${cartItem.shirt.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!removeButtons) // ซ่อน QuantitySelector เมื่อ removeButtons เป็น true
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: QuantitySelector(
                            quantity: cartItem.quantity,
                            onIncrement: () {
                              cart.updateItemQuantity(
                                  cartItem, cartItem.quantity + 1);
                            },
                            onDecrement: () {
                              if (cartItem.quantity > 1) {
                                cart.updateItemQuantity(
                                    cartItem, cartItem.quantity - 1);
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                if (cartItem.selectedSize != null ||
                    cartItem.selectedColor != null)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        if (cartItem.selectedSize != null)
                          Chip(
                            label: Text("Size: ${cartItem.selectedSize.name}"),
                            backgroundColor: Colors.grey[200],
                          ),
                        if (cartItem.selectedColor != null)
                          const SizedBox(width: 8),
                        if (cartItem.selectedColor != null)
                          Chip(
                            label:
                                Text("Color: ${cartItem.selectedColor.name}"),
                            backgroundColor: Colors.grey[200],
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (!removeButtons) // ซ่อนปุ่มกากบาทเมื่อ removeButtons เป็น true
            Positioned(
              top: 16,
              right: 28,
              child: GestureDetector(
                onTap: () {
                  cart.removeItem(cartItem);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
