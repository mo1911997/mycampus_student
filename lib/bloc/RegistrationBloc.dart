import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:placement_app/repositories/Repository.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationBloc 
{
  Repository repository = Repository();
  final firstName = BehaviorSubject<String>();
  final lastName = BehaviorSubject<String>();
  final email = BehaviorSubject<String>();
  final contact = BehaviorSubject<String>();
  final address = BehaviorSubject<String>();
  final dob = BehaviorSubject<String>();
  final courseid = BehaviorSubject<String>();
  final year = BehaviorSubject<String>();
  final rollno = BehaviorSubject<String>();
  final instituteid = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();
  Function(String) get getFirstName => firstName.sink.add;
  Function(String) get getLastName => lastName.sink.add;
  Function(String) get getEmail => email.sink.add;
  Function(String) get getContact => contact.sink.add;
  Function(String) get getAddress => address.sink.add;
  Function(String) get getDob => dob.sink.add;
  Function(String) get getCourseId => courseid.sink.add;
  Function(String) get getYear => year.sink.add;
  Function(String) get getRollNo => rollno.sink.add;
  Function(String) get getInstituteId => instituteid.sink.add;
  Function(String) get getPassword => password.sink.add;
  
  registerStudent()
  {
    Future<String> resp;
    print(dob.value);
    print(year.value);
    resp = repository.studentRegistration(firstName.value, lastName.value, email.value, contact.value, address.value, dob.value, courseid.value, year.value, rollno.value, instituteid.value, password.value); 
    return resp;
  }
  dialogLoader(context)
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
  convertListToString(value,courses)
  {
    
      for(var i in value)
      {
        courses.add(json.encode({'course':i['name'],'id':i['_id']}));
      }      
    
    print(courses.length);
    return courses;
  }
  dispose() 
  {
    firstName.close();
    lastName.close();
    email.close();
    contact.close();
    address.close();
    dob.close();
    courseid.close();
    year.close();
    rollno.close();
    instituteid.close();
    password.close();
  }
  
}
final registrationBloc = RegistrationBloc();