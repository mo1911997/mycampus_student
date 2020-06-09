import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  var connectivityResult;
  var isConnectionActive = true;
  
  @override
  void initState()
  {
    super.initState();
    checkInternetConnection();
  }
  checkInternetConnection() async
  {
      connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnectionActive = true;
      });
    } 
    else 
    {
      setState(() {
        isConnectionActive = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return isConnectionActive == false ? SafeArea(
          child: Scaffold(body: 
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Text('No internet connection !'),
        RaisedButton( 
          elevation: 0.0,
          onPressed: (){
            checkInternetConnection();
          },
          child: Text('Refresh'),
        )
      ],)),),
    ) : SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("Privacy Policy",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: <Widget>[

        ],),
        backgroundColor: Colors.blueAccent,
        body:  Row(          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.86,
              width: MediaQuery.of(context).size.width*0.90,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}