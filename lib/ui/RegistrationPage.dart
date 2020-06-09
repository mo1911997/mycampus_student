import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:placement_app/bloc/RegistrationBloc.dart';
import 'package:placement_app/providers/ApiProvider.dart';
import 'package:placement_app/ui/LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  var code;
  var c;
  RegistrationPage(this.code,this.c);
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var dropdownValueCourse;  
  var dropdownValueYear;
  var selectedDate = DateTime.now();
  var pickedDate;
  var dateController = TextEditingController();
  List<String> courses;
  var _formKey = GlobalKey<FormState>();
  Future<List> aa;
  ApiProvider apiProvider;
  String resp;
  
  
  
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate)
      setState(() {
        print(picked);
        selectedDate = picked;
        pickedDate = picked.toString().split(' ');
        dateController.text = pickedDate[0];
      });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    courses = [];    
    setState(() {
      courses = registrationBloc.convertListToString(widget.code,courses);  
    });
    
    
  }
  
  @override
  Widget build(BuildContext context) {
    return courses.length == 0 ?
    
    SafeArea(child: Scaffold(backgroundColor: Colors.blueAccent,body : Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))))  : Form(
      child: SafeArea(
              child: SafeArea(
                child: Scaffold(        
            backgroundColor: Colors.blueAccent,
            body: Column(
              children: <Widget>[
                Expanded(
                              child: ListView(
                    
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(0.0),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,                
                          children: <Widget>[
                             Container(
                               margin: EdgeInsets.only(top:10.0),
                               child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[ 
                            Text('Register Yourself !',style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold),)
                          ],),
                             ),
                        //   Image.asset('assets/splash_logo.png',          
                        // height: 130.0,
                        // width: 130.0,
                        //   repeat: ImageRepeat.noRepeat,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Container(
                         width: MediaQuery.of(context).size.width*0.90,
                          child: TextFormField( 
                            onChanged: registrationBloc.getFirstName,
                        cursorColor: Colors.white,              
                        style: new TextStyle(color: Colors.white),      
                        decoration: InputDecoration( 
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          labelText: "First Name",                      
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
                        cursorColor: Colors.white,                 
                        onChanged: registrationBloc.getLastName,
                        style: new TextStyle(color: Colors.white),   
                        decoration: InputDecoration( 
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          labelText: "Last Name",                      
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
                        cursorColor: Colors.white,                    
                        onChanged: registrationBloc.getEmail,
                        style: new TextStyle(color: Colors.white),
                        decoration: InputDecoration( 
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          labelText: "Email",                      
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
                        cursorColor: Colors.white,      
                        onChanged: registrationBloc.getContact,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        style: new TextStyle(color: Colors.white),              
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
                        cursorColor: Colors.white,          
                        onChanged: registrationBloc.getAddress,                      
                        style: new TextStyle(color: Colors.white),                              
                        maxLines: 3,
                        decoration: InputDecoration( 
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          labelText: "Address",           
                                     
                          labelStyle: TextStyle(                        
                            color: Colors.white
                          )
                        ),
                          ),
                        ), 
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          Container(
                          width: MediaQuery.of(context).size.width*0.60,
                          child: TextFormField( 
                        controller: dateController,                      
                        cursorColor: Colors.white,          
                        style: new TextStyle(color: Colors.white),                              
                        decoration: InputDecoration( 
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          labelText: "DOB",                      
                          labelStyle: TextStyle(                        
                            color: Colors.white
                          )
                        ),
                          ),
                        ), 
                        Container( 
                          margin: EdgeInsets.only(top:20.0),
                          width: MediaQuery.of(context).size.width*0.20,
                          child: IconButton( 
                            icon: Icon(Icons.date_range,size: 40.0,),
                            onPressed:() => _selectDate(context),
                          ),
                        )
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Container(
                          width: MediaQuery.of(context).size.width*0.90,
                          child:
                          
                           Theme(
                             data : Theme.of(context).copyWith(
                                canvasColor: Colors.blueAccent,
                              ),
                              child: DropdownButton<String>( 
                              value: dropdownValueCourse,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 0.0,
                              elevation: 16,
                              hint: Text('Select Course',style:TextStyle(fontSize: 16.0,color: Colors.white,fontFamily: 'Raleway') ,),                            
                              style: TextStyle(color: Colors.white),
                              underline: Container(
                                height: 1,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  
                                  dropdownValueCourse = newValue;
                                  registrationBloc.courseid.value = newValue; 
                                });
                              },
                              items: courses
                                  .map<DropdownMenuItem<String>>((String value2) {
                                return DropdownMenuItem<String>(     
                                                       
                                  value: json.decode(value2)['id'],
                                  child: Text(json.decode(value2)['course'],style: TextStyle(fontSize: 16.0,color: Colors.white,fontFamily: 'Raleway'),)
                                );
                              }).toList(),
                          ),
                           ),                   
                        ), 
                        ],),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Container(
                          width: MediaQuery.of(context).size.width*0.90,
                          child:
                          
                           Theme(
                             data : Theme.of(context).copyWith(
                                canvasColor: Colors.blueAccent,
                              ),
                              child: DropdownButton<String>( 
                              value: dropdownValueYear,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 0.0,
                              elevation: 16,
                              hint: Text('Select Year',style:TextStyle(fontSize: 16.0,color: Colors.white,fontFamily: 'Raleway') ,),                            
                              style: TextStyle(color: Colors.white),
                              underline: Container(
                                height: 1,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueYear = newValue;
                                  registrationBloc.year.value = newValue;
                                });
                              },
                              items: <String>['One', 'Two', 'Free', 'Four']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(     
                                                       
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 16.0,color: Colors.white,fontFamily: 'Raleway'),)
                                );
                              }).toList(),
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
                        cursorColor: Colors.white,          
                        onChanged: registrationBloc.getRollNo,
                        style: new TextStyle(color: Colors.white),                              
                        decoration: InputDecoration( 
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          labelText: "Roll No",                      
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
                        cursorColor: Colors.white,          
                        onChanged: registrationBloc.getPassword,
                        style: new TextStyle(color: Colors.white),   
                        obscureText: true,                           
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
                        
                                    
                        ],),
                      ),
                      
                    ],
                  ),
                ),
                Container(                    
                        width: MediaQuery.of(context).size.width*0.90,
                        child: RaisedButton(     
                          
                          onPressed: () async{
                            registrationBloc.dialogLoader(context);
                            print(widget.code);                            
                            
                            registrationBloc.instituteid.value = widget.c;
                            registrationBloc.dob.value = dateController.text;
                            
                            resp = await registrationBloc.registerStudent();
                            if(resp == "success")
                            {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context,"success");
                            }
                            else 
                            {
                              Navigator.pop(context);
                            }
                            
                          },       
                          color: Colors.blueAccent[100],       
                          child: Text('Register', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          shape: RoundedRectangleBorder(borderRadius: 
                          BorderRadius.circular(5.0)),
                        ),
                          ),    
              ],
              
            ),
            ),
        ),
      ),
      );
  }
}
