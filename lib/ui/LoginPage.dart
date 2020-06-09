import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:placement_app/bloc/LoginBloc.dart';
import 'package:placement_app/ui/ChangePasswordGetContact.dart';
import 'package:placement_app/ui/Dashboard.dart';
import 'package:placement_app/ui/GetInstituteCodeScreen.dart';
import 'package:placement_app/ui/RegistrationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode contactNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode loginNode = FocusNode();
  String resp;
  
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {    
    super.initState();   
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: WillPopScope(
        onWillPop: (){
          return null;
        },
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
                          height: 160.0,
                          width: 160.0,
                            repeat: ImageRepeat.noRepeat,
                          ),
                          Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[ 
                      Text('Login',style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold),)
                    ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            Container(
                           width: MediaQuery.of(context).size.width*0.90,
                            child: TextFormField( 
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Contact';
                                }
                                return null;
                              },
                              onChanged: loginBloc.getContact,
                              cursorColor: Colors.white,                
                              keyboardType: TextInputType.number,    
                              inputFormatters: [ 
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              style: new TextStyle(color: Colors.white),
                              focusNode: contactNode,
                              decoration: InputDecoration( 
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                labelText: "Contact",                      
                                labelStyle: TextStyle(
                                  color: Colors.white
                                )
                              ),
                            ),
                          ),
                          ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            Container(
                            width: MediaQuery.of(context).size.width*0.90,
                            child: TextFormField( 
                              onChanged: loginBloc.getPassword,
                              cursorColor: Colors.white,         
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Password !';
                                }
                                return null;
                              },
                              style: new TextStyle(color: Colors.white),     
                              focusNode: passwordNode,                          
                              decoration: InputDecoration( 
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                labelText: "Password",                                            
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
                              onPressed: () async {
                                if(_formKey.currentState.validate())
                                {
                                      loginBloc.dialogLoader(context);
                                      resp = await loginBloc.checkLogin();
                                      if(resp == "success")
                                      {
                                        FocusScope.of(context).requestFocus(loginNode);
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) => Dashboard(),
                                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                            transitionDuration: Duration(milliseconds: 1400),
                                          ),
                                        );
                                      }
                                      else 
                                      {
                                        FocusScope.of(context).requestFocus(loginNode);
                                        Navigator.pop(context);
                                        _scaffoldKey.currentState
                                        .showSnackBar(new SnackBar(content: new Text(resp,style:TextStyle(fontFamily: 'Raleway'))));
                                      }              
                                }
                                                
                              },
                              color: Colors.blueAccent[100],     
                              focusNode: loginNode,       
                              child: Text('Login', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              shape: RoundedRectangleBorder(borderRadius: 
                              BorderRadius.circular(5.0)),
                            ),
                          ),
                          Container( 
                            child :InkWell( 
                              onTap: (){
                                Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => GetInstituteCodeScreen(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                              },
                              child: Text('Not a Member ? Sign Up',style: TextStyle(color: Colors.white),),
                            )
                          ),Container( 
                            child :InkWell( 
                              onTap: () async {
                                var result;
                                result = await Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => ChangePasswordGetContact(),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 1400),
                                ),
                              );
                                print(result);
                                if(result == "success")
                                {
                                  _scaffoldKey.currentState
                                  .showSnackBar(new SnackBar(content: new Text("Registered !")));
                                }
                              },
                              child: Text('Forgot Password ?',style: TextStyle(color: Colors.white),),
                            )
                          )
                      ],),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}