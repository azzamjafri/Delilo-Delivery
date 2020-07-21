import 'package:flutter/material.dart';

import '../colors.dart';


class Payout extends StatefulWidget {
  @override
  _PayoutState createState() => _PayoutState();
}

class _PayoutState extends State<Payout> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: getBody(),
    );
  }

  getBody() {
    double y = MediaQuery.of(context).size.height;
    double x = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
        Padding(
          padding: EdgeInsets.only(top: y * 0.026),
        ),
        Padding(
            padding: EdgeInsets.only(left: x * 0.0875, bottom: y * 0.013),
            child: Row(children: [blueText('Payout', y * 0.033)],)),
        // Padding(
        //     padding: EdgeInsets.only(left: x * 0.12 , bottom: y * 0.013),
        //     child: Row(
        //       children: [
        //         Text(
        //           'Balance Rs. 4000',
        //           style: TextStyle(
        //             fontSize: y*0.019,
        //             color: greenColor,
        //           ),
        //         )
        //       ],
        //     )),
        

        Padding(
          padding: const EdgeInsets.only(top: 5.0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: y * 0.0108, horizontal: x * 0.020),
          child: SizedBox(
            height: y / 3,
            width: x,
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: y * 0.013, horizontal: x * 0.025)),

                  Container(
                      height: 60.0,
                      width: 60.0,
                      child: Image.asset('assets/1.png',)
                    ),
                  Padding(padding: EdgeInsets.all(12.0), child: blueText('History', 19.5),),
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Center(child: Text('You Recieved Rs. 4000 COD for order #10711',
                      style: TextStyle(fontSize: y*0.017),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('You Recieved Rs. 1100 COD for order #10006',
                      style: TextStyle(
                          fontSize: y*0.017
                      ),)),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  blueText(String txt, [double size = 22.0]) {
    return new Text(
      txt,
      style: new TextStyle(
          color: greenColor,
          fontSize: size,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8),
    );
  }
}
