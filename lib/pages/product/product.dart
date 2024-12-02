import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:go_kart/pages/product/product_details.dart';
import 'package:go_kart/pages/order_payment/delivery_address.dart';
import 'package:go_kart/pages/cart.dart';
import 'package:go_kart/pages/wishlist.dart';
import 'package:go_kart/functions/passDataToProduct.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Add to Cart functionality
void addToCart(PassDataToProduct productData) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Reference to the cart collection for the current user
      CollectionReference cart = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart');

      // Check if the product already exists in the cart
      var cartSnapshot =
          await cart.where('productId', isEqualTo: productData.productId).get();
      if (cartSnapshot.docs.isEmpty) {
        // If the product doesn't exist in the cart, add it
        await cart.add({
          'productId': productData.productId,
          'productImage': productData.imagePath,
          'productTitle': productData.title,
          'productPrice': productData.price,
          'productOldPrice': productData.oldPrice,
          'offerText': productData.offer,
          'quantity': 1, // You can add quantity logic here if needed
        });
        print("Product added to cart");
      } else {
        print("Product already in cart");
      }
    } else {
      print("No user is logged in");
    }
  } catch (e) {
    print("Error adding product to cart: $e");
  }
}

class ProductPage extends StatefulWidget {
  final PassDataToProduct? productData;

  const ProductPage({Key? key, this.productData}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool favourite = false;
  int cartItem = 3;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData!.title),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
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
              badgeContent: Text('$cartItem'),
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
      body: ProductDetails(data: widget.productData),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // Add to cart
                  addToCart(widget.productData!);
                  setState(() {
                    cartItem++;
                  });
                },
                child: Container(
                  width: width / 2,
                  height: 50.0,
                  color: Theme.of(context).primaryColorLight,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Delivery()));
                },
                child: Container(
                  width: width / 2,
                  height: 50.0,
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
