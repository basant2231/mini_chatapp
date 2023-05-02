import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Screens/ChatScreen.dart';
import 'Screens/RegisterationScreen.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/WelcomeScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
 MyApp({super.key});
final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:_auth.currentUser!=null? ChatScreen.ChatScreenRoute:WelcomeScreen.welcomeScreenRoute,
      routes: {
        WelcomeScreen.welcomeScreenRoute: (context) => WelcomeScreen(),
        RegisterationScreen.RegisterationScreenRoute: (context) =>
            RegisterationScreen(),
        SignInScreen.SignInScreenRoute: (context) => SignInScreen(),
        ChatScreen.ChatScreenRoute: (context) => ChatScreen(),
      },
      title: 'Message App',
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}
