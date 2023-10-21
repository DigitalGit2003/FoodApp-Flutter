import 'package:flutter/material.dart';
import 'package:food_app/screen/login_page.dart';
import 'package:food_app/screen/sign_up.dart';

class WelcomePage extends StatelessWidget {
  Widget button(
      {required BuildContext context,
      required String name,
      required dynamic func,
      Color? color,
      Color? textColor}) {
    return Container(
      height: 45,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Set background color
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => func,
            ),
          );
        },
        child: Text(
          name,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset('images/logo.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Welcome To Tastee",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Column(
                    children: [
                      Text("Order food form our restaueant and"),
                      Text("Make reservation in real- time")
                    ],
                  ),
                  button(
                      context: context,
                      name: 'Login',
                      func: LoginPage(),
                      color: Colors.green,
                      textColor: Colors.white),
                  button(
                      context: context,
                      name: 'SignUp',
                      func: SignUp(),
                      color: Colors.white,
                      textColor: Colors.green),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
