import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:placement_app/ui/LoginPage.dart';
import 'package:placement_app/ui/Posts.dart';
import 'package:placement_app/ui/PrivacyPolicy.dart';
import 'package:placement_app/ui/StudentProfile.dart';
import 'package:placement_app/ui/TermsAndConditions.dart';

import 'Events.dart';
import 'Groups.dart';
import 'MyApplications.dart';
import 'Resumes.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isConnectionActive = true;
  var storage;
  PageController pageController;
  List<String> images = [
    "https://blog.hubspot.com/hubfs/image8-2.jpg",
    "https://www.persistent.com/wp-content/uploads/2019/10/persistent-systems-header-logo.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Bank-of-New-York-Mellon-Logo.svg/1200px-Bank-of-New-York-Mellon-Logo.svg.png"
  ];
  int _currentPage = 0;
  var connectivityResult;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    try 
    {
        pageController = PageController(initialPage: 1,viewportFraction: 0.8);
        Timer.periodic(Duration(seconds: 3), (Timer timer) {
        if (_currentPage < 3) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }
     on Exception catch(e) {}
    {
      setState(() {
        isConnectionActive = false;  
      });
      
    }
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
    )
     : SafeArea(
            child: WillPopScope(
          onWillPop: (){
            return null;
          },
            child: Scaffold(
          backgroundColor: Colors.blueAccent,
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'Dashboard',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
           drawer:  Theme(
                      data : Theme.of(context).copyWith(
                      canvasColor: Colors.blueAccent, //This will change the drawer background to blue.
                      //other styles
                    ),
                    child: Drawer(
              
              child: ListView(            
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black,width: 2.0))
                  ),
                    child: IconButton(
                      
                      onPressed: (){
                          Navigator.pop(context);
                          Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => StudentProfile(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1200),
                                ),
                              );                       
                      },
                      
                      icon: Icon(Icons.supervised_user_circle,size: 100,),
                    ),                
                  ),
                  ListTile(
                    title: Center(
                      child: Text('Resumes',              
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                          Navigator.pop(context);
                       Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => Resumes(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Text('My Applications',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                        Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => MyApplications(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Text('Groups',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                        Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => Groups(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );                      
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Text('Events',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                          Navigator.pop(context);
                      Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => Events(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Text('Posts',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                       Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => Posts(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Text('Privacy Policy',              
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                          Navigator.pop(context);
                        Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => PrivacyPolicy(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Text('Terms & Conditions',              
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                        Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => TermsAndConditions(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Text('Logout',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () async {
                        storage = FlutterSecureStorage();
                        await storage.delete(key: "token");
                        Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => LoginPage(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                      
                    },
                  ),
                  
                  ListTile(
                    enabled: false,
                    title: Center(
                      child: Text('Version  :   1.0.0',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      
                      
                    },
                  ),
                ],
              ),
            ),
          ),
          body:  Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Card(
                      child: PageView.builder(                     
                        controller: pageController,                  
                        itemCount: images.length,
                        itemBuilder: (context,position){
                          return slider(position);
                        },
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),              
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container( 
                              height: MediaQuery.of(context).size.height*0.18,
                              width : MediaQuery.of(context).size.width*0.40,
                              child: Card( 
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                Container( 
                                  child: Text('0',style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
                                ),
                                Divider( 
                                  height: 5.0,
                                  color: Colors.black
                                ),
                                Column(
                                  children: <Widget>[
                                    Container( 
                                      child: Text('Companies',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                    Container( 
                                      child: Center(child: Text('Applied',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              ],),
                              ),
                            ),
                            Container( 
                              height: MediaQuery.of(context).size.height*0.18,
                              width : MediaQuery.of(context).size.width*0.40,
                              child: Card( 
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                   child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                Container( 
                                  child: Text('0',style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
                                ),
                                Divider( 
                                  height: 5.0,
                                  color: Colors.black
                                ),
                                Column(
                                  children: <Widget>[
                                    Container( 
                                      child: Text('Total Companies',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                    Container( 
                                      child: Text('Arrived',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],),
                              ),
                            ),
                          ],
                        ),
                         Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container( 
                        height: MediaQuery.of(context).size.height*0.18,
                        width : MediaQuery.of(context).size.width*0.40,
                        child: Card( 
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                Container( 
                                  child: Text('0',style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
                                ),
                                Divider( 
                                  height: 5.0,
                                  color: Colors.black
                                ),
                                Column(
                                  children: <Widget>[
                                    Container( 
                                      child: Text('Selected For',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                    Container( 
                                      child: Text('Jobs',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],),
                        ),
                      ),
                      Container( 
                        height: MediaQuery.of(context).size.height*0.18,
                        width : MediaQuery.of(context).size.width*0.40,
                        child: Card( 
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                Container( 
                                  child: Text('0',style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
                                ),
                                Divider( 
                                  height: 5.0,
                                  color: Colors.black
                                ),
                                Column(
                                  children: <Widget>[
                                    Container( 
                                      child: Text('Selected For',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                    Container( 
                                      child: Text('Internships',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],),
                        ),
                      ),
                    ],
                  ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container( 
                        height: MediaQuery.of(context).size.height*0.18,
                        width : MediaQuery.of(context).size.width*0.40,
                        child: Card( 
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                Container( 
                                  child: Text('0',style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
                                ),
                                Divider( 
                                  height: 5.0,
                                  color: Colors.black
                                ),
                                Column(
                                  children: <Widget>[
                                    Container( 
                                      child: Text('Aggregate Students',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                    Container( 
                                      child: Text('Placed',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],),
                        ),
                      ),
                      Container( 
                        height: MediaQuery.of(context).size.height*0.18,
                        width : MediaQuery.of(context).size.width*0.40,
                        child: Card( 
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                Container( 
                                  child: Text('0',style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
                                ),
                                Divider( 
                                  height: 5.0,
                                  color: Colors.black
                                ),
                                Column(
                                  children: <Widget>[
                                    Container( 
                                      child: Text('Unplaced',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                    Container( 
                                      child: Text('Students',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],),
                        ),
                      ),
                    ],
                  )
                  ],
                ),
              ),             
            ],
          ),
          
        ),
    ),
     );
  }
  slider(int position)
  {
    return AnimatedBuilder( 
      animation: pageController,
      builder: (context,widget){
        return Center( 
          child: SizedBox( 
            height: 100,
            width: 200,
            child: widget,
          ),
        );
      },      
      child: Container( 
        margin: EdgeInsets.all(10.0),
        child: Image.network(images[position],fit: BoxFit.contain,),
      ),
    );
  }
}
