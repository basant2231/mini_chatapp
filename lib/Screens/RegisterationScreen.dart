import 'package:flutter/material.dart';
import 'package:mini_chatapp/Screens/ChatScreen.dart';

import '../Widgets/MyButton.dart';
import '../Widgets/MyTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterationScreen extends StatefulWidget {
  RegisterationScreen({super.key});
  static String RegisterationScreenRoute = '/RegisterationScreen';

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  late String email;

  late String password;

  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;

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
                  ispass: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: MyButton(
                    color: Colors.cyan[600]!,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        Navigator.pushNamed(
                            context, ChatScreen.ChatScreenRoute);
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                    title: 'Register',
                  ),
                ),
              ],
            ),
          ),
          showSpinner
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
