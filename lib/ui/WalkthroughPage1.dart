import 'package:flutter/material.dart';

class WalkthroughPage1 extends StatefulWidget {
  @override
  _WalkthroughPage1State createState() => _WalkthroughPage1State();
}

class _WalkthroughPage1State extends State<WalkthroughPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Center(child: Text('Page 1',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,color: Colors.white),),
    ),
      RaisedButton( 
        onPressed: (){

        },
        child: Text('Next'),
      )
      ],));
  }
}