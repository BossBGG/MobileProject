import 'package:flutter/material.dart';
import 'package:myfirstapp/components/shirt_app_bar.dart';
import '../models/item.dart';
import '../models/stock.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ShirtPage extends StatefulWidget {
  final Shirt shirt; // รับข้อมูล Shirt ที่ถูกกดมาเป็นพารามิเตอร์

  const ShirtPage({super.key, required this.shirt}); // เพิ่มพารามิเตอร์ shirt

  @override
  State<ShirtPage> createState() => _ShirtPageState();
}

class _ShirtPageState extends State<ShirtPage> {
  int _currentImageIndex = 0;
  int _selectedStars = 0;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // ใช้ shirt ที่ถูกส่งผ่านมาใน widget.shirt
    Shirt selectedShirt = widget.shirt;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // Addbar
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
                      selectedShirt
                          .imagePath[index], // แสดงรูปตาม index ใน imagePath
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
                // Page Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(selectedShirt.imagePath.length, (index) {
                    return GestureDetector(
                      onTap: () => CarouselSlider.builder(
                        itemCount: selectedShirt.imagePath.length,
                        itemBuilder: (context, index, realIndex) =>
                            Image.asset(selectedShirt.imagePath[index]),
                        options: CarouselOptions(height: 300.0),
                      ),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.blue)
                                  .withOpacity(
                                      _currentImageIndex == index ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ] else ...[
                // ถ้ามีแค่รูปเดียว ให้แสดงรูปเดียว
                Padding(
                  padding: const EdgeInsets.only(left: 40,right: 40),
                  child: Center(
                    child: Container(
                      width: double
                          .infinity, // ปรับความกว้างให้เต็มหน้าจอเหมือน CarouselSlider
                      height: 300.0,
                      child: Image.asset(
                        selectedShirt.imagePath[
                            0], // แสดงภาพจาก index แรกเมื่อมีแค่รูปเดียว
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
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),

              // Divider
              Divider(),

              // Rating Stars และ Stock quantity
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                              if (i < 5)
                                SizedBox(width: 4), // ระยะห่างระหว่างดาว
                            ],
                          ),
                        Text("$_selectedStars/5"),
                      ],
                    ),

                    // Stock quantity ย้ายมาอยู่ด้านขวา
                    Text(
                      "Stock: ${selectedShirt.stock}", // แสดงจำนวน stock ของเสื้อแต่ละตัว
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),

              // Divider
              Divider(),

              // Description with 'More' option
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isOverflowing =
                        selectedShirt.description.length > 150;
                    final displayedText = _isExpanded || !isOverflowing
                        ? selectedShirt.description
                        : selectedShirt.description.substring(0, 150) + '...';

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
    );
  }
}
