import 'package:flutter/material.dart';

import '../Widgets/MyButton.dart';
import 'RegisterationScreen.dart';
import 'SignInScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
static String welcomeScreenRoute = '/WelcomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              child: Image.asset('lib/Images/logo.png'),
            ),
            Text(
              "Message me",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Color(0xff2e386b),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MyButton(
                color:Color.fromARGB(225, 206, 53, 130),
                onPressed: () {
                  Navigator.pushNamed(context, SignInScreen.SignInScreenRoute);
                },
                title: 'Sign in',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MyButton(
                color: Colors.cyan[600]!,
                onPressed: () {
                  Navigator.pushNamed(context, RegisterationScreen.RegisterationScreenRoute);
                },
                title: 'Register',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
