import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delilo/LoginScreen/bank_registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../colors.dart';
import 'login.dart';

String otp;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.person),
                          iconSize: height * 0.03,
                          onPressed: null),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20, left: 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Name ',
                                    hintStyle:
                                        TextStyle(fontSize: height * 0.023),
                                    border: InputBorder.none),
                                controller: nameController,
                                validator: (val) => val.isEmpty
                                    ? 'Name can not be empty'
                                    : null,
                              )))
                    ],
                  ),
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
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.email),
                          iconSize: height * 0.03,
                          onPressed: null),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                  right: width * 0.025, left: 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Email Address',
                                    hintStyle:
                                        TextStyle(fontSize: height * 0.023),
                                    border: InputBorder.none),
                                controller: emailController,
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                              )))
                    ],
                  ),
                )),
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
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.call),
                          iconSize: height * 0.03,
                          onPressed: null),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20, left: 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    hintStyle:
                                        TextStyle(fontSize: height * 0.023),
                                    border: InputBorder.none),
                                keyboardType: TextInputType.number,
                                controller: mobileController,
                                validator: (val) => val.length != 10
                                    ? 'Enter a valid 10 digit mobile number'
                                    : null,
                              )))
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: height * 0.01,
          ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               RichText(
                    text: TextSpan(
                  text: 'OTP Recievied',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: height * 0.023),
                )),
                SizedBox(
                  width: width*0.1,
                ),
               SizedBox(
                      width: width*0.5,
                      height: 50.0,
                      child: PinCodeTextField(
                        
                        backgroundColor: Colors.grey[200],
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            inactiveFillColor: brownColor,
                            activeColor: greenColor,
                            selectedColor: greenColor,
                            activeFillColor: greenColor,
                            inactiveColor: brownColor,
                          ),
                          length: 4,
                          onChanged: (val) {
                            otp = val;
                          },
                        ),
                    ),
             ],
           ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: width * 0.4,
              ),
              FlatButton(
                  onPressed: () {
                    // mobileController.text = mobileController.text.trim();
                    // codeSent
                    //     ? AuthService().signWithOTP(smsCode, verificationId)
                    //     : verifyPhone("+91" + mobileController.text);

                    // if (verified) {
                    //   setState(() {
                    //     key.currentState.showSnackBar(OTPVerifiedSnackBar);
                    //   });
                    // }
                  },
                  child: codeSent
                      ? Text("Submit the OTP Code",
                          style: TextStyle(color: Colors.green))
                      : Text("Resend OTP",
                          style: TextStyle(color: Colors.green))),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          //   child: Container(
          //       width: MediaQuery.of(context).size.width * 0.8,
          //       height: MediaQuery.of(context).size.height * 0.05,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(50),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey,
          //             blurRadius: 2,
          //             offset: Offset(0, 2),
          //           ),
          //         ],
          //       ),
          //       child: Container(
          //         padding: EdgeInsets.only(
          //             left: MediaQuery.of(context).size.width * 0.08),
          //         child: Center(
          //           child: TextFormField(
          //             decoration: InputDecoration(
          //                 hintText: 'Enter your Display Name',
          //                 hintStyle: TextStyle(fontSize: height * 0.023),
          //                 border: InputBorder.none),
          //           ),
          //         ),
          //       )),
          // ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.093,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                              // icon: Icon(Icons.location_on),
                              icon: Image.asset('assets/pppp.png', color: Colors.grey),
                              iconSize: height * 0.06,
                              onPressed: null),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20, left: 0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Address',
                                        hintStyle:
                                            TextStyle(fontSize: height * 0.026),
                                        border: InputBorder.none),
                                  )))
                        ],
                      ),
                    ],
                  ),
                )),
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
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04),
                    child: Row(
                      children: <Widget>[
                        
                        Container(
                            margin: EdgeInsets.only(right: 80, left: 40),
                            child: Text('Id proof', style: TextStyle(color: Colors.grey.shade700, fontSize: 16.0))
                            ),

                                IconButton(
                            icon: Image.asset('assets/sh.png', color: Colors.grey),
                            iconSize: height * 0.1,
                            
                            onPressed: null),
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0)),
            onPressed: () async {
              await verifyPhone("+91" + mobileController.text);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => BankRegistrationScreen()));
              if (canRegister == true) {
                // Navigator.push(context,MaterialPageRoute(builder: (context) => Details()));
              }
            },
            minWidth: MediaQuery.of(context).size.width / 1.35,
            color: greenColor,
            child: Text("Continue",
                style: TextStyle(color: Colors.white, fontSize: height * 0.04)),
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

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      // AuthService().signIn(authResult);
      FirebaseAuth.instance.signInWithCredential(authResult).then((user) async {
        if (emailController != null &&
            mobileController != null &&
            nameController != null &&
            passwordController != null) {
          canRegister = true;
        }
        await FirebaseAuth.instance.currentUser();
        await Firestore.instance
            .collection('users')
            .document(user.user.uid)
            .setData({
          "email": emailController.text,
          "password": passwordController.text,
          "phone": mobileController.text,
          "username": nameController.text,
        });
      });
      setState(() async {
        this.verified = true;
        this.loginKey = authResult;
        otpController.text = smsCode;
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');

      if (registered)
        key.currentState.showSnackBar(SnackBar(
          content: new Text('Already Registered please try Login'),
        ));

      registered = false;
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
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