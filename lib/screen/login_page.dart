import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/home_page.dart';
import 'package:food_app/screen/sign_up.dart';
import 'package:food_app/screen/welcome_page.dart';
import 'package:food_app/screen/widget/my_text_field.dart';

class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  RegExp regExp = RegExp(LoginPage.pattern.toString());
  GlobalKey<ScaffoldMessengerState> globalKey =
      GlobalKey<ScaffoldMessengerState>();
  UserCredential? userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginAuth(BuildContext context) async {
    // print("92.76% 12th science");

    try {
      // print("I am here.");
      setState(() {
        // print("success debug");
        loading = true;
      });
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      setState(() {
        // print("success debug");
        loading = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
      if (FirebaseAuth.instance.currentUser != null) {
        print(FirebaseAuth.instance.currentUser);
      }
      // print("I am there.");
    } on FirebaseAuthException catch (e) {
      setState(() {
        // print("success exception");
        // print("e.code : " + e.code);
        loading = false;
      });
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        // print("success exception 2");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('wrong credentials'),
          ),
        );
      }
    }
  }

  // void validate(BuildContext context) {
  //   if (email.text.trim().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Email can\'t be empty')),
  //     );
  //     return;
  //   } else if (!regExp.hasMatch(email.text)) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please enter a valid email')),
  //     );
  //     return;
  //   }

  //   if (password.text.trim().isEmpty) {
  //     // print("Hello guys, mein hun ls.");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('password can\'t be empty')),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     loading = true;
  //   });
  //   loginAuth(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (contet) => WelcomePage()));
          },
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          // margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 170),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  MyTextField(
                    controller: email,
                    obscureText: false,
                    hintText: 'Email',
                    icon: Icons.mail_outline,
                    iconColor: Colors.grey,
                    msg: 'Email is empty.please nakho',
                  ),
                  SizedBox(height: 30),
                  MyTextField(
                    controller: password,
                    obscureText: true,
                    hintText: 'Password',
                    icon: Icons.lock_outlined,
                    iconColor: Colors.grey,
                    msg: 'password is empty',
                  ),
                ],
              ),
              loading
                  ? CircularProgressIndicator()
                  : Container(
                      height: 60,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("validation done.");
                            loginAuth(context);
                          }
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New user?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigate to the RegisterPage when the text is tapped
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      ' Register',
                      style: TextStyle(
                        color: Colors.blue, // Make the text blue (for a link)
                        // decoration: TextDecoration.underline, // Add an underline
                      ),
                    ),
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
