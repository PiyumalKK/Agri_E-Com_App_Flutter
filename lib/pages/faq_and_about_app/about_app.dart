// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        titleSpacing: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15.0),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'GoviyaGoda Agriculture E-Commerce App',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'GoviyaGoda is an innovative agriculture e-commerce platform designed to connect farmers with buyers. Built using Flutter, it ensures a seamless and intuitive experience across both Android and iOS devices.',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'The app provides a platform for farmers to sell their produce directly to consumers, empowering them with better market access and fair pricing. Buyers can explore a wide variety of fresh agricultural products with ease.',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'GoviyaGoda was developed by Piyumal and Kavishka as part of their 5th-semester mobile application development project. It reflects their commitment to creating technology-driven solutions for the agricultural sector.',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Thank you for choosing GoviyaGoda to support sustainable agriculture and local farmers!',
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Developed by Piyumal & Kavishka',
                    style: TextStyle(fontSize: 15.0, color: Colors.blue),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
