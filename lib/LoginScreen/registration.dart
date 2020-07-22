import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delilo/Authentication/authentication.dart';
import 'package:delilo/LoginScreen/bank_registration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../colors.dart';

String otp;
FirebaseUser user;

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
  final addressController = new TextEditingController();
  

  bool privacyCheck = false;
  bool drinkingCheck = false;
  bool canRegister = false;
  int stat = 0;

  // Registration variables
  String smsCode, verificationId;
  bool codeSent = false;
  bool verified = false;
  bool registered = false;

  AuthCredential loginKey;
  File file;
  String url;
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
                    fontSize: height * 0.018),
              )),
              SizedBox(width: 2.0,),
              SizedBox(
                width: width * 0.7,
                height: 45.0,
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
                  length: 6,
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
                    mobileController.text = mobileController.text.trim();
                    codeSent
                        ? AuthService().signWithOTP(smsCode, verificationId)
                        : verifyPhone("+91" + mobileController.text);

                    if (verified) {
                      setState(() {
                        key.currentState.showSnackBar(SnackBar(content: Text('Phone Number Verified !'),));
                      });
                    }
                  },
                  child: codeSent
                      ? Text("Submit the OTP Code",
                          style: TextStyle(color: Colors.green))
                      : Text("Get OTP",
                          style: TextStyle(color: Colors.green))),
            ],
          ),

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
                              
                              icon: Image.asset('assets/pppp.png',
                                  color: Colors.grey),
                              iconSize: height * 0.06,
                              onPressed: null),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 20, left: 0),
                                  child: TextFormField(
                                    controller: addressController,
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
              onTap: () => uploadId(),
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
                            child: Text('Id proof',
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16.0))),
                        IconButton(
                            icon: Image.asset('assets/sh.png',
                                color: Colors.grey),
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
              if(stat == 0 || stat == 1) key.currentState.showSnackBar(SnackBar(content: Text('Please Upload Id Proof '),));
              else{
                if (canRegister == true) {
                   Navigator.push(context,MaterialPageRoute(builder: (context) => BankRegistrationScreen()));
                }else{
                  key.currentState.showSnackBar(SnackBar(content: Text('Something went wrong !'),));
                }
              }
              
            },
            minWidth: MediaQuery.of(context).size.width / 1.35,
            color: greenColor,
            
            child: Text( (stat == 1) ? "Uploading File.." : "Continue"
              ,
            style: TextStyle(color: Colors.white, fontSize: (stat == 1) ? height * 0.03 : height * 0.04)
            ),
            height: height * 0.08,
          ),
          
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
      FirebaseAuth.instance.signInWithCredential(authResult).then((usser) async {
        if (emailController != null &&
            mobileController != null &&
            nameController != null &&
            passwordController != null) {
          canRegister = true;
        }
        await FirebaseAuth.instance.currentUser().then((value) {
          user = value;
        });
        await Firestore.instance
            .collection('users')
            .document(usser.user.uid)
            .setData({
              "email": emailController.text,
              "phone": mobileController.text,
              "username": nameController.text,
              'address': addressController.text,
              "id_proof": url,
              "id": mobileController.text,
              'password': 'test1234',
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
      print('${authException.message}'  + '***************************************');

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
    uploadId() async {
    
    file = await FilePicker.getFile();
    setState(() {
      stat = (file == null) ? 0 : 1;
    });
    StorageReference storageReference = FirebaseStorage.instance.ref().child('user_id_proof').child(user.uid);
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
    print('File Uploaded !' + url);
    setState(() {stat = 3;});
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
