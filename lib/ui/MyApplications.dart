import 'package:flutter/material.dart';

import 'PostDetails.dart';

class MyApplications extends StatefulWidget {
  @override
  _MyApplicationsState createState() => _MyApplicationsState();
}

class _MyApplicationsState extends State<MyApplications> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("My Applications",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: <Widget>[

        ],),
        backgroundColor: Colors.blueAccent,
        body:  ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
              color: Colors.white,
                child: GestureDetector(
                  onTap: (){
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1000),
                        pageBuilder: (_, __, ___) => PostDetails(index)));
              },                          
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.20,
                  child: Row(                  
                    children: <Widget>[
                      Hero( 
                        tag: 'dash$index',
                        child: Image.network("https://picsum.photos/200/300"),
                      ),
                      Expanded(
                        child: Center(
                    child: Text('Post '+(index+1).toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),
                      ),
                  ],)
                ),
              ),
            );
          }
        ),
        
      ),
    );
  }
}