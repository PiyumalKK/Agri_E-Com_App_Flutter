// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_kart/pages/category/Fruits_Vegetables/get_products_fv.dart';
import 'package:go_kart/pages/category/top_offers.dart';

// My Own Imports
import 'package:go_kart/pages/category/top_offers_pages/get_products.dart';
import 'package:go_kart/pages/cart.dart';
import 'package:go_kart/pages/wishlist.dart';
import 'package:page_transition/page_transition.dart';

class F_Vege extends StatefulWidget {
  final PassData data;

  const F_Vege({Key? key, required this.data}) : super(key: key);

  @override
  _ToolsState createState() => _ToolsState();
}

class _ToolsState extends State<F_Vege> {
  bool progress = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        progress = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.data!.title),
        titleSpacing: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const WishlistPage()));
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
                      child: const CartPage()));
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F3F6),
      body: (progress)
          ? Center(
              child: SpinKitFoldingCube(
                color: Theme.of(context).primaryColor,
                size: 35.0,
              ),
            )
          : const GetProducts_fv(),
    );
  }
}
