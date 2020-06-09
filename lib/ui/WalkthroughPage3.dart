import 'package:flutter/material.dart';
import 'package:placement_app/ui/LoginPage.dart';

class WalkthroughPage3 extends StatefulWidget {
  @override
  _WalkthroughPage3State createState() => _WalkthroughPage3State();
}

class _WalkthroughPage3State extends State<WalkthroughPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Center(child: Text('Page 3',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,color: Colors.white),),
    ),
      RaisedButton( 
        onPressed: (){
           Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => LoginPage(),
                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                transitionDuration: Duration(milliseconds: 2000),
                              ),
                            );
        },
        child: Text('Get Started !'),
      )
      ],));
  }
}