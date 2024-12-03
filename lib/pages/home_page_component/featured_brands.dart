import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';

// My Own Imports
import 'package:go_kart/pages/category/top_offers.dart';

class FeaturedBrandSlider extends StatefulWidget {
  const FeaturedBrandSlider({super.key});

  @override
  _FeaturedBrandSliderState createState() => _FeaturedBrandSliderState();
}

class _FeaturedBrandSliderState extends State<FeaturedBrandSlider> {
  final featuredBrandList = [
    {
      'title': 'Samsung',
      'image': 'assets/featured_brands/featured_brand_1.jpg'
    },
    {
      'title': 'Philips',
      'image': 'assets/featured_brands/featured_brand_2.jpg'
    },
    {'title': 'Intel', 'image': 'assets/featured_brands/featured_brand_3.jpg'}
  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _startAutoSlide();
  }

  // Function to start the auto-slide timer
  void _startAutoSlide() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // Increment the page index and loop back to the first page when reaching the end
        _currentPage = (_currentPage + 1) % featuredBrandList.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  InkWell getStructuredGridCell(featuredBrand) {
    final item = featuredBrand;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TopOffers(title: '${item['title']}')),
        );
      },
      child: Image(
        image: AssetImage(item['image']),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      padding: const EdgeInsets.only(bottom: 0.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.topLeft,
            child: const Text(
              'Featured Brands',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: featuredBrandList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: getStructuredGridCell(featuredBrandList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
