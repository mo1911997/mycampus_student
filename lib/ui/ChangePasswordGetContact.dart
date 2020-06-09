import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placement_app/bloc/ChangePasswordBloc.dart';
import 'package:placement_app/ui/ChangePasswordOTP.dart';

class ChangePasswordGetContact extends StatefulWidget {
  @override
  _ChangePasswordGetContactState createState() => _ChangePasswordGetContactState();
}

class _ChangePasswordGetContactState extends State<ChangePasswordGetContact> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var contactNode = FocusNode();
  var buttonNode = FocusNode();
  String resp;
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
                            validator: (value){
                              if(value.isEmpty)
                              {
                                return 'Please Enter Contact No !';
                              }
                              if(value.length < 10)
                              {
                                return 'Please Enter Valid Contact No !';
                              }
                              return null;
                            },
                            cursorColor: Colors.white,      
                            focusNode: contactNode,              
                            style: new TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: changePasswordBloc.getContact,
                            inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                            decoration: InputDecoration( 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              labelText: "Enter Contact No",                      
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
                            onPressed: () async{
                              
                              if(_formKey.currentState.validate())
                              {
                                changePasswordBloc.dialogLoader(context);  
                                resp = await changePasswordBloc.changePasswordGetContact();
                                if(resp == 'success')
                                {
                                  FocusScope.of(context).requestFocus(buttonNode);
                                  Navigator.pop(context);                                  
                                  Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => ChangePasswordOTP(changePasswordBloc.getContact),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 2000),
                                    ),
                                  );                             
                                }
                                else 
                                {                                  
                                  FocusScope.of(context).requestFocus(buttonNode);
                                  Navigator.pop(context);
                                   _scaffoldKey.currentState
                                  .showSnackBar(new SnackBar(content: new Text("Contact Not Registered !",style: TextStyle(fontFamily: 'Raleway'),)));
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