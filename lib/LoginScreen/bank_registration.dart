import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delilo/LoginScreen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../colors.dart';


String otp;

class BankRegistrationScreen extends StatefulWidget {
  @override
  _BankRegistrationScreenState createState() => _BankRegistrationScreenState();
}

class _BankRegistrationScreenState extends State<BankRegistrationScreen> {
  final key = GlobalKey<ScaffoldState>();
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final mobileController = new TextEditingController();
  final otpController = new TextEditingController();
  // final textEditingController = new TextEditingController();
  // StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  // @override
  // void dispose() {
  //   errorController.close();

  //   super.dispose();
  // }
  

  
  bool privacyCheck = false;
  bool drinkingCheck = false;
  bool canRegister = false;

  // Registration variables
  String smsCode, verificationId;
  bool codeSent = false;
  bool verified = false;
  bool registered = false;
  final OTPSnackBar = SnackBar(
    content: Text("OTP Sent !"),
  );
  final OTPVerifiedSnackBar = SnackBar(
    content: Text("Phone Number Verified!"),
  );
  AuthCredential loginKey;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: getBody(),
      backgroundColor: Colors.grey[200],
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: getContents(),
      ),
    );
  }

  getContents() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            height: height * 0.2,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(child: new Image.asset('assets/logo.png')),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            height: height * 0.05,
            width: MediaQuery.of(context).size.width / 1.35,
            child: Center(
                child: new Text('Register',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: height * 0.04,
                        fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: 
                      
                      Container(
                          margin: EdgeInsets.only(right: 20, left: 40),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Account Name ',
                                hintStyle:
                                    TextStyle(fontSize: height * 0.023),
                                border: InputBorder.none),
                            controller: nameController,
                            validator: (val) => val.isEmpty
                                ? 'Name can not be empty'
                                : null,
                          ))
                    
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.013, horizontal: width * 0.025),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Container(
                      margin: EdgeInsets.only(
                          right: width * 0.025, left: 40),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'IFSC Code',
                            hintStyle:
                                TextStyle(fontSize: height * 0.023),
                            border: InputBorder.none),
                        controller: emailController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                      )),
                )),
          ),
          
          SizedBox(
            height: height * 0.01,
          ),
          
          
          
         
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){},
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      
                      Container(
                          margin: EdgeInsets.only(right: 20, left: 60),
                          child: Text('Driving Licence', style: TextStyle(color: Colors.grey[600], fontSize: 16.0))
                          ),

                              IconButton(
                          icon: Image.asset('assets/sh.png', color: Colors.grey),
                          iconSize: height * 0.12,
                          
                          onPressed: null),
                    ],
                  )),
            ),
          ),


          SizedBox(
            height: height * 0.01,
          ),
          
          
          
         
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){},
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      
                      Container(
                          margin: EdgeInsets.only(right: 60, left: 60),
                          child: Text('Pan Card', style: TextStyle(color: Colors.grey[600], fontSize: 16.0))
                          ),

                              IconButton(
                          icon: Image.asset('assets/sh.png', color: Colors.grey),
                          iconSize: height * 0.12,
                          
                          onPressed: null),
                    ],
                  )),
            ),
          ),


          SizedBox(
            height: height * 0.01,
          ),
          
          
          
         
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){},
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      
                      Container(
                          margin: EdgeInsets.only(right: 0.0, left: 50),
                          child: Text('Passport Size Photo', style: TextStyle(color: Colors.grey[600], fontSize: 16.0))
                          ),

                              IconButton(
                          icon: Image.asset('assets/sh.png', color: Colors.grey),
                          iconSize: height * 0.12,
                          
                          onPressed: null),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0)),
            onPressed: () async {
             
            },
            minWidth: MediaQuery.of(context).size.width / 3,
            color: Colors.white,
            child: Text("Cancel Check",
                style: TextStyle(color: Colors.grey[500], fontSize: height * 0.022)),
            height: height * 0.06,
          ),
          Padding(padding: EdgeInsets.only(right: 20.0)),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0)),
            onPressed: () async {
              
            },
            minWidth: MediaQuery.of(context).size.width / 3,
            color: greenColor,
            child: Text("Cancel",
                style: TextStyle(color: Colors.white, fontSize: height * 0.022)),
            height: height * 0.06,
          ),
            ],
          ),
          SizedBox(
            height: height * 0.035,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0)),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));
            },
            minWidth: MediaQuery.of(context).size.width / 1.35,
            color: greenColor,
            child: Text("Request",style: TextStyle(color: Colors.white, fontSize: height * 0.04)),
            height: height * 0.08,
          ),
          /* Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: CheckboxListTile(
              value: privacyCheck,
              onChanged: (newValue) {
                setState(() {
                  privacyCheck = newValue;
                });
              },
              title: Text('I Agree all Terms & Policies',
                  style: TextStyle(fontSize: 12.5, color: Colors.white)),
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: Colors.white,
              activeColor: Colors.blueGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: CheckboxListTile(
              value: drinkingCheck,
              onChanged: (newValue) {
                setState(() {
                  drinkingCheck = newValue;
                });
              },
              title: Text(
                  'I Agree that I have legal drinking age\nas per state domocile',
                  style: TextStyle(fontSize: 12.5, color: Colors.white)),
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: Colors.white,
              activeColor: Colors.blueGrey,
            ),
          ), */
          SizedBox(
            height: height * 0.02,
          ),
          
          Padding(padding: EdgeInsets.all(15.0)),
        ],
      ),
    );
  }


}

// ignore: camel_case_types
class otpField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: width * 0.0375),
      height: height * 0.04,
      width: width * 0.075,
      child: Container(
          alignment: Alignment.bottomCenter,
          child: TextField(
            decoration:
                InputDecoration(counterText: '', border: InputBorder.none),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            maxLengthEnforced: true,
            onChanged: (value) {
              otp = otp + value.toString();
              print(otp);
            },
          )),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}