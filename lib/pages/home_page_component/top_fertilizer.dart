import 'package:flutter/material.dart';

// My Own Imports
import 'package:go_kart/pages/category/top_offers.dart';

class TopSeller extends StatelessWidget {
  final topSellerList = [
    {
      'title': 'Top Selling Organic Fertilizers',
      'image': 'assets/top_seller/1.png'
    },
    {
      'title': 'Top Selling Chemical Fertilizers',
      'image': 'assets/top_seller/2.png'
    },
  ];

  TopSeller({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(topSeller) {
      final item = topSeller;
      return InkWell(
        child: Image(
          image: AssetImage(item['image']),
          fit: BoxFit.fitHeight,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TopOffers(title: '${item['title']}')),
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: width - 20.0,
      child: GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        crossAxisCount: 2,
        children: List.generate(topSellerList.length, (index) {
          return getStructuredGridCell(topSellerList[index]);
        }),
      ),
    );
  }
}
