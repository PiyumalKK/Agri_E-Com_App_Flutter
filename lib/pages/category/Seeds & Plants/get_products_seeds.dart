import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// My Own Imports
import 'package:go_kart/pages/category/top_offers_pages/filter_row.dart';
import 'package:go_kart/pages/product/product.dart';
import 'package:go_kart/functions/passDataToProduct.dart';
import 'package:page_transition/page_transition.dart';

class GetProducts_seeds extends StatefulWidget {
  const GetProducts_seeds({super.key});

  @override
  _GetProductsState createState() => _GetProductsState();
}

class _GetProductsState extends State<GetProducts_seeds> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
      future: loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }

        return snapshot.hasData
            ? ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  const FilterRow(),
                  const Divider(
                    height: 1.0,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: ProductsGridView(products: snapshot.data!)),
                ],
              )
            : Center(
                child: SpinKitFoldingCube(
                color: Theme.of(context).primaryColor,
                size: 35.0,
              ));
      },
    );
  }
}

class ProductsGridView extends StatefulWidget {
  final List<Products>? products;

  const ProductsGridView({Key? key, this.products}) : super(key: key);

  @override
  _ProductsGridViewState createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  InkWell getStructuredGridCell(Products products) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Hero(
                  tag: products.productTitle,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      products.productImage,
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
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(right: 6.0, left: 6.0),
              child: Column(
                children: <Widget>[
                  Text(
                    products.productTitle,
                    style: const TextStyle(fontSize: 12.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "\RS ${products.productPrice}",
                        style: const TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      Text(
                        "Rs ${products.productOldPrice}",
                        style: const TextStyle(
                            fontSize: 13.0,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Text(
                    products.offerText,
                    style: const TextStyle(
                        color: Color(0xFF67A86B), fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(microseconds: 600),
                child: ProductPage(
                  productData: PassDataToProduct(
                      products.productTitle,
                      products.productId,
                      products.productImage,
                      products.productPrice,
                      products.productOldPrice,
                      products.offerText),
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 2,
      childAspectRatio: ((width) / (height - 150.0)),
      children: List.generate(widget.products!.length, (index) {
        return getStructuredGridCell(widget.products![index]);
      }),
    );
  }
}

class Products {
  int productId;
  String productImage;
  String productTitle;
  String productPrice;
  String productOldPrice;
  String offerText;

  Products(this.productId, this.productImage, this.productTitle,
      this.productPrice, this.productOldPrice, this.offerText);
}

Future<List<Products>> loadProducts() async {
  try {
    // Fetch data from Firestore
    var snapshot =
        await FirebaseFirestore.instance.collection('Seeds & Plants').get();

    // Check if snapshot is empty
    if (snapshot.docs.isEmpty) {
      print("No products found in Firestore");
      return [];
    }

    List<Products> products = [];
    for (var doc in snapshot.docs) {
      var data = doc.data(); // Get the data from the document
      // Map Firestore data to Products model
      Products product = Products(
          data['productId'],
          data['productImage'],
          data['productTitle'],
          data['productPrice'],
          data['productOldPrice'],
          data['offerText']);
      products.add(product);
    }

    return products;
  } catch (e) {
    print("Error fetching products: $e");
    return [];
  }
}
