import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:myfirstapp/page/welcome_page.dart';
import 'package:myfirstapp/models/stock.dart';
import 'package:myfirstapp/models/cart.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Stock()), // Provider สำหรับ Stock
        ChangeNotifierProvider(create: (context) => Cart()), // Provider สำหรับ Cart ถ้ามี
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const WelcomePage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
      ),
    );
  }
}
