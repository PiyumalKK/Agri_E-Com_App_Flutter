import 'package:flutter/material.dart';

// My Own Imports
import 'package:go_kart/pages/category/top_offers.dart';

class BestDealGrid extends StatelessWidget {
  final bestDealList = [
    {
      'title': 'Find Experienced Farm Workers',
      'image': 'assets/best_deal/6.png'
    },
    {
      'title': 'Sell Your Agricultural Products',
      'image': 'assets/best_deal/7.png'
    }
  ];

  BestDealGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(bestDeal) {
      final item = bestDeal;
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
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      width: width - 20.0,
      child: GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(8.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        crossAxisCount: 2,
        childAspectRatio:
            (width / 2) / 200, // Adjust the aspect ratio for smaller cells
        children: List.generate(bestDealList.length, (index) {
          return getStructuredGridCell(bestDealList[index]);
        }),
      ),
    );
  }
}
