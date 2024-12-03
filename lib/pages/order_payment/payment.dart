import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_kart/pages/home.dart';

class PaymentPage extends StatefulWidget {
  final String pinCode;
  final String locality;
  final String city;
  final String state;

  const PaymentPage({
    super.key,
    required this.pinCode,
    required this.locality,
    required this.city,
    required this.state,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int? selectedRadioPayment;

  @override
  void initState() {
    super.initState();
    selectedRadioPayment = 0;
  }

  setSelectedRadioPayment(int val) {
    setState(() {
      selectedRadioPayment = val;
    });
  }

  Future<void> _saveOrderToFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User is not signed in.");
      }

      final orderData = {
        'shippingAddress': {
          'pinCode': widget.pinCode,
          'locality': widget.locality,
          'city': widget.city,
          'state': widget.state,
        },
        'paymentMethod': selectedRadioPayment == 1
            ? 'Credit / Debit Card'
            : 'Cash On Delivery',
        'orderDate': FieldValue.serverTimestamp(),
        'orderStatus': 'Pending',
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .add(orderData);

      print("Order successfully added to Firestore!");
    } catch (e) {
      print("Error saving order: $e");
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: SizedBox(
            height: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  child:
                      const Icon(Icons.check, color: Colors.white, size: 50.0),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Yuppy !!",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Your Payment Received.",
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Choose your payment method',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Alatsi',
                      height: 1.6),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: width - 40.0,
                  child: RadioListTile(
                    value: 1,
                    groupValue: selectedRadioPayment,
                    title: const Text(
                      "Credit / Debit Card",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    onChanged: (val) {
                      setSelectedRadioPayment(val!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                const Divider(height: 1.0),
                SizedBox(
                  width: width - 40.0,
                  child: RadioListTile(
                    value: 2,
                    groupValue: selectedRadioPayment,
                    title: const Text(
                      "Cash On Delivery",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    onChanged: (val) {
                      setSelectedRadioPayment(val!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                const SizedBox(height: 40.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: InkWell(
                    onTap: () {
                      _saveOrderToFirestore();
                      _showDialog();
                    },
                    child: Container(
                      width: width - 40.0,
                      padding: const EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Text(
                        'Confirm Payment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
