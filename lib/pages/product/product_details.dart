import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_kart/pages/product/rating_row.dart';
import 'package:go_kart/pages/product/get_similar_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetails extends StatefulWidget {
  final data;

  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool favourite = false;
  Color color = Colors.grey;

  // Add to Wishlist function
  void addToWishlist() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Reference to the wishlist collection for the current user
        CollectionReference wishlist = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('wishlist');

        // Check if the product already exists in the wishlist
        var wishlistSnapshot = await wishlist
            .where('productId', isEqualTo: widget.data.productId)
            .get();

        if (wishlistSnapshot.docs.isEmpty) {
          // If the product doesn't exist in the wishlist, add it
          await wishlist.add({
            'productId': widget.data.productId,
            'productImage': widget.data.imagePath,
            'productTitle': widget.data.title,
            'productPrice': widget.data.price,
            'productOldPrice': widget.data.oldPrice,
            'offerText': widget.data.offer,
          });
          setState(() {
            favourite = true;
            color = Colors.red;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Added to Wishlist")));
        } else {
          setState(() {
            favourite = false;
            color = Colors.grey;
          });
          // If the product is already in the wishlist, remove it
          var docId = wishlistSnapshot.docs.first.id;
          await wishlist.doc(docId).delete();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Removed from Wishlist")));
        }
      } else {
        print("No user is logged in");
      }
    } catch (e) {
      print("Error adding/removing product from wishlist: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        // Image and Add to Wishlist Code Starts Here
        Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              color: Colors.white,
              child: Hero(
                tag: '${widget.data.title}',
                child: SizedBox(
                  height: height / 2.0,
                  child: Image.network(
                    widget.data.imagePath,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image,
                        size: 50.0,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 3.0,
                onPressed: addToWishlist, // Trigger add to wishlist
                child: Icon(
                  (!favourite)
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        // Image and Add to Wishlist Code Ends Here
        Container(
            color: Colors.white,
            child: const SizedBox(
              height: 8.0,
            )),
        const Divider(
          height: 1.0,
        ),
        // Product Details
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Title
              Text(
                '${widget.data.title}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              // Price & Offer Row
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'RS ${widget.data.price}',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'RS ${widget.data.oldPrice}',
                      style: const TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${widget.data.offer} off',
                      style: TextStyle(fontSize: 14.0, color: Colors.red[700]),
                    ),
                  ],
                ),
              ),
              // Rating Row
              const RatingRow(),
            ],
          ),
        ),
        // Similar Product Section
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          color: Colors.white,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Similar Products',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              GetSimilarProducts(),
            ],
          ),
        ),
      ],
    );
  }
}
