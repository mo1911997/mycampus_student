import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:placement_app/ui/LoginPage.dart';
import 'package:placement_app/ui/RegistrationPage.dart';
import 'package:placement_app/ui/Walkthrough.dart';

import 'Dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var screenName;
  var storage;
  checkToken() async 
  {
    storage = FlutterSecureStorage();
    if( await storage.read(key:'token') == null)
    {
      print('inside null');
      screenName = Walkthrough();
    }
    else 
    {      
      print('inside yes');
      screenName = Dashboard();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
       Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => screenName,
                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                transitionDuration: Duration(milliseconds: 2000),
                              ),
                            );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor:Colors.blueAccent,
            body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/splash_logo.png',
            
            height: 200.0,
            width: 200.0,
              repeat: ImageRepeat.noRepeat,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text('My Campus',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0),)
            ],)
          ],
        )),
      ),
    );
  }
}
