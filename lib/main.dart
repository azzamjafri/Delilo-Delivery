import 'package:delilo/LoginScreen/login.dart';
import 'package:delilo/LoginScreen/registration.dart';
import 'package:flutter/material.dart';

import 'Authentication/authentication.dart';
import 'colors.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delilo Delivery',
      theme: ThemeData(
        primarySwatch: blueColor,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: AuthService().handleAuth(),
      // home: RegistrationScreen(),
      
    );
  }
}
