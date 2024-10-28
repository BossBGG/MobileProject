import 'package:flutter/material.dart';
import 'package:myfirstapp/components/shirt_app_bar.dart';
import '../models/item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myfirstapp/components/add_cart_button.dart';
import '../models/color_utils.dart';

class ShirtPage extends StatefulWidget {
  final Shirt shirt; //ข้อมูล Shirt ที่ถูกกดมาเป็นพารามิเตอร์

  const ShirtPage({super.key, required this.shirt});

  @override
  State<ShirtPage> createState() => _ShirtPageState();
}

class _ShirtPageState extends State<ShirtPage> {
  int _currentImageIndex = 0;
  int _selectedStars = 0;
  bool _isExpanded = false;
  ShirtSize? _selectedSize;
  ShirtColor? _selectedColor;
  int _quantity = 1;

  void _showAddToCartDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text("เลือกขนาด สี และจำนวน"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
 // เลือกขนาด
Text("เลือกขนาด"),
SizedBox(height: 10),
Wrap(
  spacing: 8,
  children: widget.shirt.availableSize.map((size) {
    return ChoiceChip(
      label: Text(
        size.name,
        style: TextStyle(
          color: _selectedSize == size ? Colors.white : Colors.black,
        ),
      ),
      selected: _selectedSize == size,
      onSelected: (selected) {
        setState(() {
          _selectedSize = selected ? size : null; // เปลี่ยนขนาดที่เลือก
        });
      },
      selectedColor: Colors.blue, // สีพื้นหลังเมื่อเลือก
      backgroundColor: Colors.grey[200], // สีพื้นหลังเมื่อไม่เลือก
    );
  }).toList(),
),
              Divider(),

              // เลือกสี
              Text("เลือกสี"),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: widget.shirt.availableColor.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: getColorFromName(color.name), // เรียกใช้ฟังก์ชันที่นี่
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedColor == color
                              ? Colors.blue[800]!
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Divider(),

              // ตัวเลือกจำนวน
              Text("จำนวน"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text("$_quantity"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ยกเลิก"),
            ),
            TextButton(
              onPressed: () {
                // เพิ่มสินค้าในตะกร้าด้วยขนาด สี และจำนวนที่เลือก
                Navigator.pop(context);
              },
              child: Text("เพิ่มในตะกร้า"),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Shirt selectedShirt = widget.shirt;  // ใช้ shirt ที่ถูกส่งผ่านมาใน widget.shirt

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              // Addbar
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                ShirtAppBar(),
              ],
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Slider for images
                    if (selectedShirt.imagePath.length > 1) ...[
                      CarouselSlider.builder(
                        itemCount: selectedShirt.imagePath.length,
                        itemBuilder: (context, index, realIndex) {
                          return Image.asset(
                            selectedShirt.imagePath[index],
                            fit: BoxFit.cover,
                          );
                        },
                        options: CarouselOptions(
                          height: 300.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                        ),
                      ),
                      // Page Indicators (จุดเลื่อน)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          selectedShirt.imagePath.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.blue)
                                      .withOpacity(_currentImageIndex == index
                                          ? 0.9
                                          : 0.4),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ] else ...[
                      // ถ้ามีแค่รูปเดียว ให้แสดงรูปเดียว
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            height: 300.0,
                            child: Image.asset(
                              selectedShirt.imagePath[0],  // แสดงภาพจาก index แรกเมื่อมีแค่รูปเดียว
                              height: 300.0,
                              fit: BoxFit.cover, // ปรับการแสดงผลรูปภาพให้อยู่ในกรอบ
                            ),
                          ),
                        ),
                      ),
                    ],
                    // Shirt name
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        selectedShirt.name,
                        style:
                            TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),

                    //เส้นกั่น
                    Divider(),

                    // Rating Stars and Stock quantity
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Rating Stars 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 1; i <= 5; i++)
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.star,
                                        color: i <= _selectedStars
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectedStars = i;
                                        });
                                      },
                                    ),
                                    if (i < 5) SizedBox(width: 4),
                                  ],
                                ),
                              Text("$_selectedStars/5"),
                            ],
                          ),
                          // Stock quantity
                          Text(
                            "Stock: ${selectedShirt.stock}",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),

                    Divider(),

                    // Description with 'More' option
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LayoutBuilder( //เงื่อนไขจำนวนตัวอักษร
                        builder: (context, constraints) {
                          final isOverflowing =
                              selectedShirt.description.length > 150;
                          final displayedText = _isExpanded || !isOverflowing
                              ? selectedShirt.description
                              : selectedShirt.description.substring(0, 150) +
                                  '...';

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayedText,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              if (isOverflowing)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isExpanded = !_isExpanded;
                                      });
                                    },
                                    child: Text(
                                      _isExpanded ? 'Less' : 'More',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // AddtoCart Buttom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AddCartButton(
              onTap: _showAddToCartDialog,
              text: "Add to Cart",
            ),
          ),
        ],
      ),
    );
  }
}
