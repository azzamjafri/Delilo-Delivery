import 'package:delilo/OrderScreen/OrderPage.dart';
import 'package:delilo/PayIn/payin.dart';
import 'package:delilo/PayOut/payout.dart';
import 'package:delilo/Profile/profile.dart';
import "package:flutter/material.dart";

import '../colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getTabs(),
    );
  }

  getBody() {
    return SafeArea(
      child: Expanded(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            OrderPage(),
            Payout(),
            Payin(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }

  getTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, -4.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 4,
        indicatorColor: greenColor,
        labelColor: greenColor,
        unselectedLabelColor: Colors.black,
        
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: greenColor, width: 6.0),
          insets: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 45.0),
        ),
        // physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        tabs: [
          Tab(icon: Text("Order")),
          Tab(
            icon: Text("Payout"),
          ),
          Tab(
            icon: Text("Payin"),
          ),
          Tab(
            icon: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
