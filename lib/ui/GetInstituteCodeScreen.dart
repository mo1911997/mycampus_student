import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placement_app/providers/ApiProvider.dart';

import 'RegistrationPage.dart';

class GetInstituteCodeScreen extends StatefulWidget {
  @override
  _GetInstituteCodeScreenState createState() => _GetInstituteCodeScreenState();
}

class _GetInstituteCodeScreenState extends State<GetInstituteCodeScreen> {
  var codeController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var apiProvider;
  List aa;
  var codeNode = FocusNode();
  var buttonNode = FocusNode();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {    
    super.initState();
    aa = [];
  }
    dialogLoader()
  {
                 
          AlertDialog alert = AlertDialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            content: Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[CircularProgressIndicator(backgroundColor: Colors.blueAccent,)],)),
            
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        
  }
  @override
  Widget build(BuildContext context) {
    
        return SafeArea(
                  child: Form(
                key: _formKey,
                child: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Colors.blueAccent,
                  body: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      
                      Container(
                        padding: EdgeInsets.all(0.0),
                        height: MediaQuery.of(context).size.height,
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
                              Container(
                             width: MediaQuery.of(context).size.width*0.90,
                              child: TextFormField( 
                                focusNode: codeNode,
                                validator: (value){
                                  if(value.isEmpty)
                                  {
                                    return 'Please enter valid institute code !';
                                  }
                                  return null;
                                },
                                cursorColor: Colors.white,                    
                                style: new TextStyle(color: Colors.white),                                                           
                                controller: codeController,
                            decoration: InputDecoration( 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              labelText: "Enter Institute Code",                      
                              labelStyle: TextStyle(
                                color: Colors.white
                              )
                            ),
                          ),
                        ),
                        ],),                      
                        Container(
                          width: MediaQuery.of(context).size.width*0.90,
                          child: RaisedButton(   
                            focusNode: buttonNode,        
                            onPressed: () async {
                              if(_formKey.currentState.validate())
                              {
                                dialogLoader();
                                apiProvider = ApiProvider();
                                aa = await apiProvider.getCourses(codeController.text);
                                if(aa.length == 0)
                                {
                                  FocusScope.of(context).requestFocus(buttonNode);
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState
                                    .showSnackBar(new SnackBar(content: new Text("Invalid Institute Code !",style:TextStyle(fontFamily: 'Raleway'))));
                                }
                                else 
                                {
                                  FocusScope.of(context).requestFocus(buttonNode);
                                  Navigator.pop(context);
                                    Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => RegistrationPage(aa,codeController.text),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 1400),
                                  ),
                                );
                                }
                              }
                               
                            },        
                            color: Colors.blueAccent[100],            
                            child: Text('Proceed', style: TextStyle(color: Colors.white),),
                            shape: RoundedRectangleBorder(borderRadius: 
                            BorderRadius.circular(5.0)),
                          ),
                        ),                      
                    ],),
                  ),
                ],
              ),
      ),
    ),
        );
  }
}