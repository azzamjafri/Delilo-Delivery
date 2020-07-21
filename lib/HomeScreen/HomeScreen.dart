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

class _HomeScreenState extends State<HomeScreen>with SingleTickerProviderStateMixin{

  TabController tabController;
  @override
  void initState() {
    tabController=TabController(length: 4,vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  getBody() {
    return SafeArea(
      child: Row(
        children: [
          Container(
            color: blueColor,
            width: 50,
            child: RotatedBox(
              quarterTurns: 3,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4,
                indicatorColor: brownColor,
                labelColor: brownColor,
                unselectedLabelColor: Colors.white,
                // physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                tabs: [
                  Tab(
                    icon: Text("Order")
                  ),
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
            )
          ),
          Expanded(
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
          )
        ],
      ),
    );
  }
}
