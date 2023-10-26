import 'package:flutter/material.dart';
import 'package:food_app/screen/home_page.dart';

class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text('Thank You'),
      ),
      body: Center(
        child: Text('Thank you for your purchase!'),
      ),
    );
  }
}