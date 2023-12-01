import 'dart:convert';

import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/user/userHome.dart';
import 'package:emmorceapp/services/paymentService.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPage extends StatefulWidget {
  final String totalAmount;

  PaymentPage({required this.totalAmount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _address = '';
  String _transactionType = '';
  double _totalAmount = 0.0;
  String _upiId = '';
  String _creditCardNumber = '';
  bool _showCreditCardField = false;
  bool _showUPIField = false;
  TextEditingController addcontroller=TextEditingController();

  void _setTransactionType(String? value) {
    if (value != null) {
      setState(() {
        _transactionType = value;
        if (_transactionType == 'Credit Card') {
          _showCreditCardField = true;
          _showUPIField = false;
        } else if (_transactionType == 'UPI') {
          _showCreditCardField = false;
          _showUPIField = true;
        } else {
          _showCreditCardField = false;
          _showUPIField = false;
        }
      });
    }
  }

  void _submitCreditCard() {
    setState(() {
      _showCreditCardField = false;
    });
  }

  void _submitUPI() {
    setState(() {
      _showUPIField = false;
    });
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: Text('Payment done successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const HomePage(),
                        type: PageTransitionType.bottomToTop));
              },
            ),
          ],
        );
      },
    );
  }

  late SharedPreferences prefs;
  int? userid;

  void initState() {
    super.initState();
    _initializeUserID();
    _viewProfile();
  }

  Future<void> _initializeUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getInt('userid') ?? 0);
      print(userid);
    });
  }

  PaymentService client = PaymentService();

  Future<void> _viewProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = (prefs.getInt('userid') ?? 0);

    final url =
        Apiconstants.baseurl + Apiconstants.view_profile + userid.toString();
    var response = await http.get(Uri.parse(url));
    //   print("harshana");
    var body = json.decode(response.body);
    setState(() {
      _address = body['data']['Address'];
      addcontroller.text=_address;
      print(_address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        titleSpacing: 0.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4.0,
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: addcontroller,
                        onChanged: (value) {
                          setState(() {
                            _address = value;
                          });
                        },
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Enter your shipping address',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Card(
                elevation: 4.0,
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Transaction Type',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      RadioListTile<String>(
                        title: Text('Cash on Delivery'),
                        value: 'Cash on Delivery',
                        groupValue: _transactionType,
                        onChanged: _setTransactionType,
                      ),
                      RadioListTile<String>(
                        title: Text('Credit Card'),
                        value: 'Credit Card',
                        groupValue: _transactionType,
                        onChanged: _setTransactionType,
                      ),
                      RadioListTile<String>(
                        title: Text('UPI'),
                        value: 'UPI',
                        groupValue: _transactionType,
                        onChanged: _setTransactionType,
                      ),
                      if (_showCreditCardField)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Enter Credit Card Number',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _creditCardNumber = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your credit card number',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(15.0),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _submitCreditCard,
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      if (_showUPIField)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Enter UPI ID',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _upiId = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your UPI ID',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(15.0),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _submitUPI,
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount: \$${widget.totalAmount}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await client.payment(
                            userId: userid ?? 0,
                            context: context,
                            paymentMethod: _transactionType,
                            address: _address,
                          );
                          _showPaymentSuccessDialog();
                        } catch (e) {
                          print('Payment failed: $e');
                          // Handle payment failure here
                        }
                      },
                      child: Text('Pay Now'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
