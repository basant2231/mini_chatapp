import 'package:flutter/material.dart';

import '../Widgets/MyButton.dart';
import '../Widgets/MyTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ChatScreen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});
  static String SignInScreenRoute = '/SignInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;

  late String password;

  bool spinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 180,
                  child: Image.asset('lib/Images/logo.png'),
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextField(
                  textt: 'Enter your Email',
                  onChanged: (value) {
                    email = value;
                  },
                  ispass: false,
                ),
                SizedBox(
                  height: 8,
                ),
                MyTextField(
                  textt: 'Enter your Password',
                  onChanged: (value) {
                    password = value;
                  },
                  ispass: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: MyButton(
                    color: Color.fromARGB(225, 206, 53, 130),
                    onPressed: () async {
                      setState(() {
                        spinner=true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, ChatScreen.ChatScreenRoute);
                      } catch (e) {
                        print(e);
                      }
                       setState(() {
                        spinner=false;
                      });
                    },
                    title: 'Sign In',
                  ),
                ),
              ],
            ),
            
          ),spinner
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
