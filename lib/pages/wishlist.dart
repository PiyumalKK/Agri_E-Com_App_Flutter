import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// My Own Imports
import 'package:go_kart/pages/home.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late User _user;
  bool _isLoading = true;
  List<Map<String, dynamic>> _wishlistItems = [];

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _fetchWishlist();
  }

  // Fetch the wishlist items from Firestore
  Future<void> _fetchWishlist() async {
    try {
      final wishlistSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection('wishlist')
          .get();

      setState(() {
        _wishlistItems = wishlistSnapshot.docs.map((doc) {
          return {
            'productTitle': doc['productTitle'],
            'productImage': doc['productImage'],
            'productPrice': doc['productPrice'],
            'productId': doc.id,
          };
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle errors if necessary
    }
  }

  // Remove item from Firestore wishlist
  Future<void> _removeItemFromWishlist(String productId, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection('wishlist')
          .doc(productId)
          .delete();

      setState(() {
        _wishlistItems.removeAt(index);
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item Removed from Wishlist'),
      ));
    } catch (e) {
      // Handle errors if necessary
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to remove item'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _wishlistItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        FontAwesomeIcons.heartCrack,
                        color: Colors.grey,
                        size: 60.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'No Item in Wishlist',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        child: const Text(
                          'Go To Home',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _wishlistItems.length,
                  itemBuilder: (context, index) {
                    final item = _wishlistItems[index];
                    return Slidable(
                      key: ValueKey(item['productId']),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.16,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _removeItemFromWishlist(item['productId'], index);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              width: MediaQuery.of(context).size.width * 0.16,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: Container(
                        height: 180.0,
                        padding: const EdgeInsets.all(5.0),
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
                                  SizedBox(
                                    width: 120.0,
                                    height: 160.0,
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
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        item['productTitle'],
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Text(
                                            'Price:',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Rs ${item['productPrice']}',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
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
