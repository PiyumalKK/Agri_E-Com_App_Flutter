import 'package:flutter/material.dart';

// My Own Imports
import 'package:go_kart/pages/category/top_offers.dart';

class BestOfferGrid extends StatelessWidget {
  final bestOffers = [
    {'title': 'Farm Equipments', 'image': 'assets/best_offer/1.png'},
    {'title': 'Best Deals on Plows', 'image': 'assets/best_offer/2.png'},
    {'title': 'Affordable Irrigation Tools', 'image': 'assets/best_offer/3.png'}
  ];

  BestOfferGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(bestOffer) {
      final item = bestOffer;
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
        crossAxisCount: 3,
        children: List.generate(bestOffers.length, (index) {
          return getStructuredGridCell(bestOffers[index]);
        }),
      ),
    );
  }
}
