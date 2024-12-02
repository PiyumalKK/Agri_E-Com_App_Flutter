import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool price1 = false, price2 = false, price3 = false;
  bool brand1 = false, brand2 = false, brand3 = false;
  bool type1 = false, type2 = false, type3 = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: width / 2,
                  height: 50.0,
                  color: Theme.of(context).primaryColorLight,
                  alignment: Alignment.center,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: width / 2,
                  height: 50.0,
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            sectionHeader('Price Range'),
            checkbox("Below Rs. 1,000", price1),
            checkbox("Rs. 1,000 to Rs. 5,000", price2),
            checkbox("Above Rs. 5,000", price3),
            sectionDivider(),
            sectionHeader('Brands'),
            checkbox("AgriPro", brand1),
            checkbox("FarmMate", brand2),
            checkbox("GreenTech", brand3),
            sectionDivider(),
            sectionHeader('Product Type'),
            checkbox("Seeds", type1),
            checkbox("Fertilizers", type2),
            checkbox("Tools & Equipment", type3),
          ],
        ),
      ),
    );
  }

  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: boolValue,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool? value) {
            setState(() {
              switch (title) {
                case "Below Rs. 1,000":
                  price1 = value!;
                  break;
                case "Rs. 1,000 to Rs. 5,000":
                  price2 = value!;
                  break;
                case "Above Rs. 5,000":
                  price3 = value!;
                  break;
                case "AgriPro":
                  brand1 = value!;
                  break;
                case "FarmMate":
                  brand2 = value!;
                  break;
                case "GreenTech":
                  brand3 = value!;
                  break;
                case "Seeds":
                  type1 = value!;
                  break;
                case "Fertilizers":
                  type2 = value!;
                  break;
                case "Tools & Equipment":
                  type3 = value!;
                  break;
              }
            });
          },
        ),
        Text(title),
      ],
    );
  }

  Widget sectionHeader(String title) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget sectionDivider() {
    return const Divider(
      height: 1.0,
    );
  }
}
