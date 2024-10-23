import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchfield extends StatefulWidget {
  const MySearchfield({super.key});

  @override
  State<MySearchfield> createState() => _MySearchfieldState();
}

class _MySearchfieldState extends State<MySearchfield> {

  // searchController
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
                controller: searchController,
                onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus!.unfocus(),
                decoration:  InputDecoration(
                  
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100)
                  ),
                  
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade800)
                  ),

                  prefixIcon: Icon(CupertinoIcons.search),
                  hintText: "Search Your Product",
                ),
    );
  }
}