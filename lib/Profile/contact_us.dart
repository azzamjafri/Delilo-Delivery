import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  
  @override

  _ContactUsState createState() => _ContactUsState();
}



class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Contact Us'),
        centerTitle: true,
        
      ),
      body: Container(
        child: Text('Contact Us'),
      ),
    );
  }
}