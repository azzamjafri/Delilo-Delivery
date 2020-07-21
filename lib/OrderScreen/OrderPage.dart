import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'active_cash_on_delivery.dart';




class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin{
  TabController tabView;
  String name = "";
  @override
  void initState() {
    tabView=TabController(length: 3,vsync: this,initialIndex: 1);
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Welcome $name",style: TextStyle(color: blueColor),),
        elevation: 0,
        bottom: getTabBar(),
      ),
      body: getBody(),

    );
  }

  getTabBar() {
    return TabBar(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue[100]
      ),
      //indicatorColor: Colors.black,
      controller: tabView,
      tabs: [
        Tab(
          icon: getTabHeader("New Order"),
        ),
        Tab(
          icon: getTabHeader("Active Order"),
        ),
        Tab(
          icon: getTabHeader("Past Order"),
        )
      ],
    );
  }

  getBody() {
    return TabBarView(
      controller: tabView,
      children: [
        Text("1"),
        ActiveOrderCashOnDelivery(),
        Text("3"),
      ],
    );
  }

  getTabHeader(String field) {
    return Text(field, style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: 12.5),);
  }

  getName() async {

    var user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection('delivery-users').document(user.uid).get().then((value) {
        setState(() {
          name = value.data['name'];
        });
    });

  }
}
