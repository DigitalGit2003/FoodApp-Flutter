import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/welcome_page.dart';
import 'package:food_app/screen/widget/my_text_field.dart';

class SignUp extends StatefulWidget {
  static final Pattern emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  UserCredential? userCredential;
  final RegExp regExp = RegExp(SignUp.emailPattern.toString());
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> globalKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> sendData(BuildContext context) async {
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      //------------------first create database in firebase then and only collection(table) can be created-----------------
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential!.user?.uid)
          .set({
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "userid": userCredential!.user?.uid,
        "password": password.text.trim(),
      });

      setState(() {
        loading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration successful"),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        // print("e.code : " + e.code);
        loading = false;
      });
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The password provided is too weak."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The account already exists for that email"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } 
  }

  void validation(BuildContext context) {
    // print("Hello guys, mein hun gautam.");

    if (firstName.text.trim().isEmpty) {
      // print("Hello guys, mein hun fn.");
      // globalKey.currentState?.showSnackBar(
      //   SnackBar(content: Text('First Name is empty')),
      // );
      // return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('First Name can\'t be empty')),
      );
      return;
    }

    if (lastName.text.trim().isEmpty) {
      // print("Hello guys, mein hun ls.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Last Name can\'t be empty')),
      );
      return;
    }

    if (email.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email can\'t be empty')),
      );
      return;
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }

    if (password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password can\'t be empty')),
      );
      return;
    }

    setState(() {
      loading = true;
    });
    sendData(context);
  }

  Widget button({
    required String buttonName,
    required Color color,
    required Color textColor,
    required Function ontap,
  }) {
    return Container(
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          ontap();
        },
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 19, color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextField(
                      controller: firstName,
                      obscureText: false,
                      hintText: 'First Name',
                      icon: Icons.person,
                    ),
                    MyTextField(
                      controller: lastName,
                      obscureText: false,
                      hintText: 'Last Name',
                      icon: Icons.person,
                    ),
                    MyTextField(
                      controller: email,
                      obscureText: false,
                      hintText: 'Email',
                      icon: Icons.mail,
                    ),
                    MyTextField(
                      controller: password,
                      obscureText: true,
                      hintText: 'Password',
                      icon: Icons.lock,
                    )
                  ],
                ),
              ),
              loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                          ontap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomePage(),
                              ),
                            );
                          },
                          buttonName: "Auth",
                          color: Colors.grey,
                          textColor: Colors.black,
                          
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        button(
                          ontap: () {
                            validation(context);
                          },
                          buttonName: "Signup",
                          color: Colors.red,
                          textColor: Colors.white,                          
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
