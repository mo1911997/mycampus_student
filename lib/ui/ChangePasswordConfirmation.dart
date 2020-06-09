import 'package:flutter/material.dart';
import 'package:placement_app/bloc/ChangePasswordBloc.dart';

class ChangePasswordConfirmation extends StatefulWidget {
  @override
  _ChangePasswordConfirmationState createState() => _ChangePasswordConfirmationState();
}

class _ChangePasswordConfirmationState extends State<ChangePasswordConfirmation> {
  var confirmPasswordController = TextEditingController();
  var resp;
  var newPasswordController = TextEditingController();
  var newPwdNode = FocusNode();
  var confirmPwdNode = FocusNode();
  var buttonNode = FocusNode();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
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
                            cursorColor: Colors.white,     
                            controller: newPasswordController,
                            focusNode: newPwdNode,
                            validator: (value){
                              if(value.isEmpty)
                              {
                                return 'This field is required !';
                              }
                              if(value.length < 6)
                              {
                                return 'Password should be atleast 6 characters long !';
                              }
                              return null;
                            },       
                            style: new TextStyle(color: Colors.white),       
                            onChanged: changePasswordBloc.getPassword, 
                            obscureText: true,
                            decoration: InputDecoration( 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              labelText: "New Password",                      
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
                            focusNode: confirmPwdNode,
                            cursorColor: Colors.white,            
                            validator: (value){
                              if(value.isEmpty)
                              {
                                return 'This field is required !';
                              }
                              if(value.length < 6)
                              {
                                return 'Password should be atleast 6 characters long !';
                              }                              
                              return null;
                            },
                            controller: confirmPasswordController,
                            style: new TextStyle(color: Colors.white),        
                            obscureText: true,
                            decoration: InputDecoration( 
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              labelText: "Confirm Password",                      
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
                              print(confirmPasswordController.text);
                              print(changePasswordBloc.getPassword.toString());
                                if(confirmPasswordController.text == newPasswordController.text)
                                {
                                  
                                  resp = await changePasswordBloc.changePasswordConfirmation();
                                  if(resp == 'success')
                                  {
                                    changePasswordBloc.dialogLoader(context);
                                    FocusScope.of(context).requestFocus(buttonNode);
                                    Navigator.pop(context);
                                    for(int i=0;i<3;i++)
                                    {
                                      Navigator.pop(context);                                    
                                    }
                                  }
                                  else 
                                  {
                                    changePasswordBloc.dialogLoader(context);
                                    FocusScope.of(context).requestFocus(buttonNode);
                                    Navigator.pop(context);
                                    _scaffoldKey.currentState
                                  .showSnackBar(new SnackBar(content: new Text("Please try again later !")));
                                  }
                                }  
                                else 
                                {
                                    _scaffoldKey.currentState
                                  .showSnackBar(new SnackBar(content: new Text("Passwords doesn\'t match !")));
                                }                                                            
                              
                            },    
                            color: Colors.blueAccent[100],                
                            child: Text('Change Password', style: TextStyle(color: Colors.white),),
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