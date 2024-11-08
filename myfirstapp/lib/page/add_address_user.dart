import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_button.dart';
import 'package:myfirstapp/components/select_address_bar.dart';

class AddAddressUser extends StatefulWidget {
  const AddAddressUser({super.key});

  @override
  State<AddAddressUser> createState() => _AddAddressUserState();
}

class _AddAddressUserState extends State<AddAddressUser> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _subDistrictController = TextEditingController();
  final _districtController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  void _addAddress() {
    if (_formKey.currentState!.validate()) {
      final newAddress = {
        'name': _nameController.text,
        'province': _provinceController.text,
      };
      Navigator.pop(context, newAddress);
    }
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
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("เพิ่มที่อยู่", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: "ชื่อที่อยู่"),
                        validator: (value) =>
                            value!.isEmpty ? "กรุณาใส่ชื่อที่อยู่" : null,
                      ),
                      TextFormField(
                        controller: _subDistrictController,
                        decoration: InputDecoration(labelText: "ตำบล"),
                        validator: (value) =>
                            value!.isEmpty ? "กรุณาใส่ตำบล" : null,
                      ),
                      TextFormField(
                        controller: _districtController,
                        decoration: InputDecoration(labelText: "อำเภอ"),
                        validator: (value) =>
                            value!.isEmpty ? "กรุณาใส่อำเภอ" : null,
                      ),
                      TextFormField(
                        controller: _provinceController,
                        decoration: InputDecoration(labelText: "จังหวัด"),
                        validator: (value) =>
                            value!.isEmpty ? "กรุณาใส่จังหวัด" : null,
                      ),
                      TextFormField(
                        controller: _postalCodeController,
                        decoration: InputDecoration(labelText: "รหัสไปรษณีย์"),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "กรุณาใส่รหัสไปรษณีย์" : null,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: "เบอร์โทรศัพท์"),
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? "กรุณาใส่เบอร์โทรศัพท์" : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  onTap: _addAddress, 
                  text: "เพิ่มที่อยู่"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
