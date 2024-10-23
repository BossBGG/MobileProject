import 'package:flutter/material.dart';
import 'package:myfirstapp/components/my_drawer.dart';
import 'package:myfirstapp/components/featured_tile.dart';
import 'package:myfirstapp/components/my_searchfield.dart';
import 'package:myfirstapp/components/my_sliver_app_bar.dart';
import 'package:provider/provider.dart';
import '../components/my_categories.dart';
import '../components/promotion_tile.dart';
import '../components/ิbest_sell_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(),
        ],
        body: Container(
          color: Colors.grey.shade100,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children:  [
                        // Searchfield
                        MySearchfield(),
                        
                        // Categories
                        MyCategories(),

                        // Featured
                        FeaturedTile(),

                        // BestSell
                        BestSellTile(),
                        
                        //  Promotion
                        PromotionTile(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}