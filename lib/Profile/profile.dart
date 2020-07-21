import 'package:flutter/material.dart';

import '../colors.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
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
        
        // Padding(
        
        

        Padding(
          padding: const EdgeInsets.only(top: 5.0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: y * 0.0108, horizontal: x * 0.090),
          child: SizedBox(
            height: y / 3.5,
            width: x,
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: y * 0.013, horizontal: x * 0.025)),

                  Center(
                    child: Container(
                        height: 80.0,
                        width: 80.0,
                        child: Image.asset('assets/1.png',)
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 5.0),
                    child: blueText('Brianna Hansen'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 5.0),
                    child: Text('(+91) 1111 1111 11',
                      style: TextStyle(fontSize: y*0.017),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 5.0),
                    child: Text('Bhasen@gmail.com',
                      style: TextStyle(fontSize: y*0.017),),
                  ),
                  
                ],
              ),
            ),
          ),
        ),

        Align(alignment: Alignment.centerLeft , child: Padding(padding: EdgeInsets.only(left: 40.0, top: 10.0), child: blueText('Address'),),),
        Padding(
          padding: EdgeInsets.symmetric(vertical: y * 0.0108, horizontal: x * 0.090),
          child: SizedBox(
            height: y / 2.18,
            width: x,
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: y * 0.013, horizontal: x * 0.025)),

                 
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 5.0, right: 40.0),
                    child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: TextStyle(fontSize: y*0.017),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 50.0,
                          width: 50.0,
                          child: Image.asset('assets/dello14.png',)
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  blueText(String txt, [double size = 22.0]) {
    return new Text(
      txt,
      style: new TextStyle(
          color: greenColor,
          fontSize: size,
          // fontWeight: FontWeight.bold,
          letterSpacing: 0.8),
    );
  }
}
