import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_kart/pages/home.dart';
import 'package:go_kart/pages/order_payment/delivery_address.dart';
import 'package:page_transition/page_transition.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = true;
  int cartTotal = 0;
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  // Fetching user and cart data from Firestore
  Future<void> _fetchCartItems() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Fetching cart data from the user's cart subcollection in Firestore
        QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .get();

        setState(() {
          cartItems = cartSnapshot.docs.map((doc) {
            return {
              'productId': doc.id,
              'productTitle': doc['productTitle'],
              'productImage': doc['productImage'],
              'productPrice':
                  doc['productPrice'], // It might be a string in Firestore
            };
          }).toList();

          // Calculate the cart total by parsing productPrice as an integer
          cartTotal = cartItems.fold<int>(0, (sum, item) {
            int price = int.tryParse(item['productPrice'].toString()) ??
                0; // Parse price to int
            return sum + price;
          });

          isLoading = false;
        });
      } catch (e) {
        print("Error fetching cart items: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Show AlertDialog if there are no items in the cart
  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text("No Item in Cart"),
          actions: <Widget>[
            TextButton(
              child: Text("Close",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Remove item from cart
  Future<void> _removeItemFromCart(String itemId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .doc(itemId)
            .delete();

        setState(() {
          cartItems.removeWhere((item) => item['productId'] == itemId);
          cartTotal = cartItems.fold<int>(0, (sum, item) {
            int price = int.tryParse(item['productPrice'].toString()) ?? 0;
            return sum + price;
          });
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Item Removed')));
      }
    } catch (e) {
      print("Error removing item from cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.7;
    double widthFull = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: widthFull,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: (widthFull / 2),
                height: 50.0,
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'Total: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Rs $cartTotal',
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (cartTotal == 0) {
                    showAlertDialog();
                  } else {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Delivery()),
                    );
                  }
                },
                child: Container(
                  width: (widthFull / 2),
                  height: 50.0,
                  color: cartTotal == 0
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (cartItems.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(FontAwesomeIcons.basketShopping,
                          color: Colors.grey, size: 60.0),
                      const SizedBox(height: 10.0),
                      const Text('No Item in Cart',
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10.0),
                      TextButton(
                        child: const Text('Go To Home',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.16,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _removeItemFromCart(item['productId']);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 3.0),
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              alignment: Alignment.center,
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: height / 5.0,
                        child: Card(
                          elevation: 3.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      width: 120.0,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        item['productImage'],
                                        fit: BoxFit.fitHeight,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.broken_image,
                                            size: 50.0,
                                            color: Colors.grey,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                width: (width - 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item['productTitle'],
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 7.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          'Price: ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Text(
                                          'Rs ${item['productPrice']}',
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 7.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(width: 10.0),
                                        InkWell(
                                          child: Container(
                                            color: Colors.grey,
                                            padding: const EdgeInsets.all(5.0),
                                            child: const Icon(
                                              FontAwesomeIcons.plus,
                                              size: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
