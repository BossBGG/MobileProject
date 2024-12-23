import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_button.dart';
import 'package:myfirstapp/components/select_address_bar.dart';
import 'package:myfirstapp/components/add_address_button.dart';
import 'package:myfirstapp/page/add_address_user.dart';
import 'package:myfirstapp/page/checklist_page.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  List<Map<String, String>> addresses = [];
  int? selectedAddressIndex; // ตัวแปรเก็บ index ของที่อยู่ที่เลือก

  void _navigateToAddAddress() async {
    final newAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAddressUser()),
    );

    if (newAddress != null) {
      setState(() {
        addresses.add(newAddress);
      });
    }
  }

  void _removeAddress(int index) {
    setState(() {
      addresses.removeAt(index);
      if (selectedAddressIndex == index) {
        selectedAddressIndex = null; // ถ้าลบที่อยู่ที่เลือกก็ต้องยกเลิกการเลือก
      }
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedAddressIndex == index) {
        selectedAddressIndex = null; // ถ้าเลือกที่อยู่นั้นแล้ว กดอีกครั้งเพื่อยกเลิกการเลือก
      } else {
        selectedAddressIndex = index; // เลือกที่อยู่ใหม่
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SelectAddressBar(),
        ],
        body: Container(
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("เลือกที่อยู่", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Expanded(
                  child: addresses.isEmpty
                      ? Center(
                          child: Text(
                            "ไม่มีที่อยู่",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            final address = addresses[index];
                            return ListTile(
                              leading: Checkbox(
                                value: selectedAddressIndex == index, // เช็คว่า checkbox นี้ถูกเลือกหรือไม่
                                onChanged: (value) {
                                  _toggleSelection(index); // เรียกฟังก์ชันเพื่อเลือกหรือยกเลิกการเลือกที่อยู่
                                },
                              ),
                              title: Text(address['name'] ?? ""),
                              subtitle: Text(address['province'] ?? ""),
                              trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => _removeAddress(index),
                              ),
                            );
                          },
                        ),
                ),
                AddAddressButton(
                  onTap: _navigateToAddAddress,
                  text: "เพิ่มที่อยู่",
                ),
                if (addresses.isNotEmpty && selectedAddressIndex != null) // แสดงปุ่มชำระเงินถ้ามีการเลือกที่อยู่แล้ว
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: MyButton(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ChecklistPage(),
                          ),
                        );
                      },
                      text: "ชำระเงิน",
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
