import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placement_app/bloc/ChangePasswordBloc.dart';
import 'package:placement_app/ui/ChangePasswordConfirmation.dart';

class ChangePasswordOTP extends StatefulWidget {
  var contact;
  ChangePasswordOTP(this.contact);
  @override
  _ChangePasswordOTPState createState() => _ChangePasswordOTPState();
}

class _ChangePasswordOTPState extends State<ChangePasswordOTP> {
  String resp;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var otpNode = FocusNode();
  var buttonNode = FocusNode();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Form(
            key : _formKey,
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
                            focusNode: otpNode,
                            validator: (value){
                              if(value.isEmpty)
                              {
                                return 'Please Enter OTP';
                              }
                              if(value.length != 4)
                              {
                                return 'Please Enter Valid OTP';
                              }
                              return null;
                            },
                            cursorColor: Colors.white,                    
                            style: new TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4)
                              ],
                              onChanged: changePasswordBloc.getOTP,
                            decoration: InputDecoration( 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              labelText: "Enter OTP",                      
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
                                changePasswordBloc.dialogLoader(context);  
                                resp = await changePasswordBloc.changePasswordVerifyOTP();
                                if(resp == 'success')
                                {
                                  FocusScope.of(context).requestFocus(buttonNode);
                                    Navigator.pop(context);
                                        Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) => ChangePasswordConfirmation(),
                                          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                          transitionDuration: Duration(milliseconds: 2000),
                                        ),
                                      );
                                }
                                else 
                                {
                                  changePasswordBloc.dialogLoader(context);
                                  FocusScope.of(context).requestFocus(buttonNode);
                                   Navigator.pop(context);
                                   _scaffoldKey.currentState
                                  .showSnackBar(new SnackBar(content: new Text("Invalid OTP!")));
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