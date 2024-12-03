import 'package:flutter/material.dart';
import 'package:go_kart/pages/category/Fruits_Vegetables/products_fv.dart';
import 'package:go_kart/pages/category/Seeds%20&%20Plants/products_seeds.dart';

// My Own Imports
import 'package:go_kart/pages/category/top_offers.dart';
import 'package:go_kart/pages/category/top_offers_pages/tools.dart'; // Import the Tools widget
// Import the correct PassData class

class CategoryGrid extends StatelessWidget {
  final categoryList = [
    {'title': 'Top Offers', 'image': 'assets/category/8.png'},
    {'title': 'Fruits & Vegetables', 'image': 'assets/category/1.png'},
    {'title': 'Seeds & Plants', 'image': 'assets/category/6.png'},
    {'title': 'Farming Equipment', 'image': 'assets/category/7.png'},
    {'title': 'Soil & Fertilizers', 'image': 'assets/category/5.png'},
    {'title': 'Flowers', 'image': 'assets/category/3.png'},
    {'title': 'Pesticides & Herbicides', 'image': 'assets/category/4.png'},
    {'title': 'Dairy Products', 'image': 'assets/category/2.png'},
  ];

  CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(category) {
      final item = category;

      // Mapping category titles to respective pages
      Map<String, Widget> categoryPages = {
        'Top Offers': TopOffers(title: '${item['title']}'),
        'Farming Equipment': Tools(
            data: PassData(
                '${item['title']}')), // Corrected to pass data to Tools widget
        'Fruits & Vegetables': F_Vege(data: PassData('${item['title']}')),
        'Seeds & Plants': Seeds(data: PassData('${item['title']}')),
        'Soil & Fertilizers':
            TopOffers(title: '${item['title']}'), // Example placeholder
        'Flowers': TopOffers(title: '${item['title']}'), // Example placeholder
        'Pesticides & Herbicides':
            TopOffers(title: '${item['title']}'), // Example placeholder
        'Dairy Products':
            TopOffers(title: '${item['title']}'), // Example placeholder
      };

      return InkWell(
        child: Image(
          image: AssetImage(item['image']),
          fit: BoxFit.fitHeight,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => categoryPages[item['title']]!,
            ),
          );
        },
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      width: width - 20.0,
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        crossAxisSpacing: 0,
        mainAxisSpacing: 15,
        crossAxisCount: 4,
        childAspectRatio: ((width) / 400),
        children: List.generate(categoryList.length, (index) {
          return getStructuredGridCell(categoryList[index]);
        }),
      ),
    );
  }
}
