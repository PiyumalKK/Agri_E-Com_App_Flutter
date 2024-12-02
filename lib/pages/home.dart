import 'dart:io';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fluttertoast/fluttertoast.dart';

// My Own Import
import 'package:go_kart/pages/home_page_component/drawer.dart';
import 'package:go_kart/pages/home_page_component/category_grid.dart';
import 'package:go_kart/pages/home_page_component/best_farm_equipment.dart';
import 'package:go_kart/pages/home_page_component/top_fertilizer.dart';
import 'package:go_kart/pages/home_page_component/best_deal.dart';
import 'package:go_kart/pages/home_page_component/featured_brands.dart';

import 'package:go_kart/pages/notifications.dart';
import 'package:go_kart/pages/category/top_offers.dart';
import 'package:go_kart/pages/cart.dart';
import 'package:go_kart/pages/search.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      appBar: AppBar(
        title: const Text(
          'Goviya Goda 🌾', // Updated title for the agriculture store
          style: TextStyle(
            fontFamily: 'Pacifico',
          ),
        ),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          IconButton(
            icon: badges.Badge(
              badgeContent: const Text('2'),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Theme.of(context).primaryColorLight,
              ),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifications()),
              );
            },
          ),
          IconButton(
            icon: badges.Badge(
              badgeContent: const Text('3'),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Theme.of(context).primaryColorLight,
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const CartPage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 5.0),

          // 🌾 Crop Categories Section
          _buildSectionTitle('🌾 Crop Categories'),
          CategoryGrid(),

          const SizedBox(height: 5.0),
          const Divider(height: 1.0),
          const SizedBox(height: 4.0),

          // 🧺 Top Offers on Seeds Section
          _buildSectionTitle('🧺 Top Offers on Seeds 🌱'),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const TopOffers(title: 'Top Offers on Seeds 🌱'),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: const Image(
                  image: AssetImage('assets/promotion/promotion1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 5.0),
          const Divider(height: 1.0),
          const SizedBox(height: 2.0),

          // 🚜 Best Farm Equipment Section
          _buildSectionTitle('🚜 Best Farm Equipment'),
          BestOfferGrid(),

          const SizedBox(height: 4.0),
          const Divider(height: 1.0),
          const SizedBox(height: 4.2),

          // 🪴 Top Fertilizers Section
          _buildSectionTitle('🪴 Top Fertilizers'),
          TopSeller(),

          const SizedBox(height: 3.8),
          const Divider(height: 1.0),
          const SizedBox(height: 4.0),

          // 💰 Best Deals on Tools Section
          _buildSectionTitle('💰 Best Deals on Agriculture'),
          BestDealGrid(),

          const SizedBox(height: 3.8),
          const Divider(height: 1.0),
          const SizedBox(height: 8.0),

          // 🔖 Featured Agricultural Brands Section
          _buildSectionTitle('🔖 Featured Agricultural Ads'),
          FeaturedBrandSlider(),

          const SizedBox(height: 6.0),
          const Divider(height: 1.0),
          const SizedBox(height: 6.0),

          const SizedBox(height: 6.0),
          const Divider(height: 1.0),
          const SizedBox(height: 0.0),

          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false;
    } else {
      return true;
    }
  }
}
