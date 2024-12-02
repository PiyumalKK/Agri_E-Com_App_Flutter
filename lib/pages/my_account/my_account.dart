import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_kart/pages/faq_and_about_app/about_app.dart';
import 'package:go_kart/pages/faq_and_about_app/faq.dart';

// My Own Imports
import 'package:go_kart/pages/login.dart';
import 'package:go_kart/pages/my_account/account_setting.dart';
import 'package:go_kart/pages/my_orders.dart';
import 'package:go_kart/pages/notifications.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String username = '';
  String profileImageUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'] ?? 'UserName';
            profileImageUrl =
                userDoc['profile_picture'] ?? 'https://default-url.com';
            isLoading = false;
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            width: width,
            height: 360.0,
            child: Stack(
              children: <Widget>[
                Image(
                  image: const AssetImage('assets/user_profile/background.jpg'),
                  width: width,
                  height: 220.0,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 165.0,
                  right: ((width / 2) - 50.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 110.0,
                        width: 110.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55.0),
                          border: Border.all(color: Colors.white, width: 5.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : Image.network(
                                  profileImageUrl,
                                  height: 100.0,
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          username,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          child: const Text(
                            'Edit Profile',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                          onTap: () {
                            // Handle Edit Profile navigation
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const Notifications()));
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.bell,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0, left: 70.0),
            child: Divider(
              height: 1.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const MyOrders()));
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.truck,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    'My Orders',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0, left: 70.0),
            child: Divider(
              height: 1.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AccountSetting()));
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.gears,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    'Account Setting',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0, left: 70.0),
            child: Divider(
              height: 1.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const FaqPage()));
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.circleQuestion,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    'FAQ',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0, left: 70.0),
            child: Divider(
              height: 1.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const AboutApp()));
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.info,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    'About App',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0, left: 70.0),
            child: Divider(
              height: 1.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.rightFromBracket,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
