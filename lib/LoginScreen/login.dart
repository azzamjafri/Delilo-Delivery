import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delilo/LoginScreen/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../HomeScreen/HomeScreen.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkBox = false;
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;
  bool verified = false;
  final idController = TextEditingController();
  final passwordController = new TextEditingController();
  final key = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  bool canLogin = false;
  String _userNumber = "", _password = "";

  @override
  void initState() {
    getVerified();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.grey[200],
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: getContents(),
      ),
    );
  }

  getContents() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Container(
            height: height*0.2,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(child: new Image.asset('assets/logo.png')),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: Center(
                child: new Text('Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height*0.04,
                        fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 1.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              boxShadow: [
                
                // BoxShadow(spreadRadius: 6.0, offset: Offset(15.0, 15.0), color: Colors.grey[500])

                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 5.0), //(x,y)
                    blurRadius: 6.0,
                  ),

              ]
            ),
            
            child: new TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                hintText: 'Enter Your ID',
                hintStyle: TextStyle(
                  fontSize: height*0.02
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              controller: idController,
              keyboardType: TextInputType.number,
              validator: (val) => val.isEmpty ? 'ID can\'t be empty' : null,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 1.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              boxShadow: [
                
                // BoxShadow(spreadRadius: 6.0, offset: Offset(15.0, 15.0), color: Colors.grey[500])

                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 5.0), //(x,y)
                    blurRadius: 6.0,
                  ),

              ]
            ),
            child: new TextFormField(
              textAlign: TextAlign.center,
              
              decoration: InputDecoration(
                
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                hintText: 'Enter Your Password',
                hintStyle: TextStyle(
                    fontSize: height*0.02
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              controller: passwordController,
              validator: (val) => val.length < 6
                  ? 'Enter a valid minimum 6 chars long password'
                  : null,
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
                onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen())),
           
            minWidth: MediaQuery.of(context).size.width / 1.35,
            color: Colors.green,
            child: Text("Login",
              style: TextStyle(
                  fontSize: height*0.02,
                color: Colors.white
              ),),
            height: height*0.08,
          ),
          SizedBox(
            height: 45.0,
          ),
          getRegisterRow(),
        ],
      ),
    );
  }

  getRegisterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text('Don\'t have an Id yet ? ',
            style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => RegistrationScreen()));
          },
          child:
              Text('Request ID', style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.green)),
        )
      ],
    );
  }

  getVerified() async {

  }
}
