import 'package:flutter/material.dart';

import 'package:go_kart/pages/cart.dart';
import 'package:go_kart/pages/category/top_offers.dart';
import 'package:go_kart/pages/faq_and_about_app/about_app.dart';
import 'package:go_kart/pages/faq_and_about_app/faq.dart';
import 'package:go_kart/pages/login.dart';
import 'package:go_kart/pages/admin/manage_products.dart'; // New page for managing products
import 'package:go_kart/pages/admin/manage_orders.dart'; // New page for managing orders
import 'package:go_kart/pages/admin/manage_users.dart'; // New page for managing users
import 'package:go_kart/pages/admin/statistics.dart'; // New page for viewing statistics
import 'package:go_kart/pages/admin/settings.dart'; // New page for settings

class MainDrawer_Admin extends StatelessWidget {
  const MainDrawer_Admin({super.key});

  @override
  Widget build(BuildContext context) {
    // Logout AlertDialog Start Here
    void showAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Confirm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text("Are you sure you want to logout?"),
            actions: <Widget>[
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
                      Icons.store,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Add Products',
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
                      builder: (context) => const ManageProducts()),
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
                      Icons.receipt_long,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Manage Orders',
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
                  MaterialPageRoute(builder: (context) => const ManageOrders()),
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
                      Icons.group,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Manage Users',
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
                  MaterialPageRoute(builder: (context) => const ManageUsers()),
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
                      Icons.pie_chart,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Statistics',
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
                  MaterialPageRoute(builder: (context) => const Statistics()),
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
                      Icons.settings,
                      color: Colors.grey[700],
                      size: 20.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Settings',
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
                  MaterialPageRoute(builder: (context) => const Settings()),
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
