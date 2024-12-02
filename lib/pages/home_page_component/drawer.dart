import 'package:flutter/material.dart';

import 'package:go_kart/pages/cart.dart';
import 'package:go_kart/pages/category/top_offers.dart';
import 'package:go_kart/pages/faq_and_about_app/about_app.dart';
import 'package:go_kart/pages/faq_and_about_app/faq.dart';
import 'package:go_kart/pages/login.dart';
import 'package:go_kart/pages/my_account/my_account.dart';
import 'package:go_kart/pages/my_orders.dart';
import 'package:go_kart/pages/notifications.dart';
import 'package:go_kart/pages/wishlist.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Logout AlertDialog Start Here
    void showAlertDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: const Text(
              "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text("Are you Sure you want to Logout?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: Text(
                  "Close",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              TextButton(
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
    // Logout AlertDialog Ends Here

    return Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: const DecorationImage(
                  image: AssetImage('assets/goviyagoda1.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_offer,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Special Offers',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TopOffers(title: 'Special Offers')),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'My Orders',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyOrders()),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'My Cart',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'My Wishlist',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WishlistPage()),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'My Account',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyAccount()),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Farm Alerts',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Notifications()),
                );
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.devices,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Farm Equipment',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TopOffers(title: 'Farm Equipment')),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.local_florist,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Plants & Seeds',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TopOffers(title: 'Plants & Seeds')),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.format_paint,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Agricultural Tools',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TopOffers(title: 'Agricultural Tools')),
                );
              },
            ),
            const Divider(
              color: Colors.grey,
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.help_outline,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'FAQ & Help',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FaqPage()),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'About the App',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutApp()),
                );
              },
            ),
            InkWell(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 7.0, bottom: 7.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                showAlertDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}
