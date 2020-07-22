import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delilo/LoginScreen/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../colors.dart';
import 'registration.dart';


String otp;

class BankRegistrationScreen extends StatefulWidget {
  
  @override
  _BankRegistrationScreenState createState() => _BankRegistrationScreenState();
}

class _BankRegistrationScreenState extends State<BankRegistrationScreen> {
  final key = GlobalKey<ScaffoldState>();
  final accountNameController = new TextEditingController();
  final ifscController = new TextEditingController();
  
  List<File> files = new List<File>();
  

  bool uploading = false;  
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
  var driving_licence;
  var pan_card;
  var passport;

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
                            controller: accountNameController,
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
                        controller: ifscController,
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
              onTap: ()  async {

                  File file = await FilePicker.getFile();
                  files.add(file);
                // driving_licence = uploadDoc('driving_licence');
              },
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
                          
                          onPressed: () async {
                            File file = await FilePicker.getFile();
                            files.add(file);
                            
                            print(files[0].path + ' *************************************8');
                          }),
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
              onTap: () async  {
                  File file = await FilePicker.getFile();
              files.add(file);
                // pan_card =  uploadDoc('pan_card');
              },
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
              onTap: () async {
                    File file = await FilePicker.getFile();
                    files.add(file);
                // passport = uploadDoc('passport_photo');
              } ,
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
                          
                          onPressed: () async {
                                          File file = await FilePicker.getFile();
                      files.add(file);
                          }),
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
            onPressed: () {},
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
            onPressed: () {},
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
            onPressed: () async {
              // print(user.uid + ' ********************************************');
              setState(() => uploading = true);
              await uploadFiles();
              try{
                await Firestore.instance.collection('users').document(user.uid).updateData({
                'account_name': accountNameController.text,
                'ifsc': ifscController.text,
                'driving_licence': driving_licence,
                'pan_card': pan_card,
                'passport_photo': passport,
              }).then((value) => Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => LoginPage()), (route) => false));
              }catch(error) {
                print(error.toString() + ' &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
              }
              Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              
            },
            minWidth: MediaQuery.of(context).size.width / 1.35,
            color: greenColor,
            child: uploading ? Text("Uploading files please wait",style: TextStyle(color: Colors.white, fontSize: height * 0.015))
              :
              Text("Request",style: TextStyle(color: Colors.white, fontSize: height * 0.04)),
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
  uploadFiles() async {
    int i=0;
    
    while(i<=files.length) {
      if(i == 0){
        driving_licence = await uploadUtil('driving_licence', files[0]);
        i++;
      }else if(i == 1) {
        pan_card = await uploadUtil('pan_card', files[1]);
        i++;
      }else if(i == 2){
        passport = await uploadUtil('photo', files[2]);
        i++;
      }else{
        setState(() => uploading = false);
        i++;
      }
        
    }
 
    
    
  }

  uploadUtil(service, file) async {
     StorageReference storageReference = FirebaseStorage.instance.ref().child(service).child(user.uid);
          StorageUploadTask uploadTask = storageReference.putFile(file);
          await uploadTask.onComplete;
          return await storageReference.getDownloadURL();
          // url = await storageReference.getDownloadURL();
  }

}

