import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placement_app/repositories/Repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc 
{
  Repository repository = Repository();
  final firstname = BehaviorSubject<String>();
  final lastname = BehaviorSubject<String>();
  final email = BehaviorSubject<String>();
  final contact = BehaviorSubject<String>();
  final address = BehaviorSubject<String>();
  final dob = BehaviorSubject<String>();
  final rollno = BehaviorSubject<String>();
  final course = BehaviorSubject<String>();
  final year = BehaviorSubject<String>();
  Function(String) get getFirstName => firstname.sink.add;
  Function(String) get getLastName => lastname.sink.add;  
  Function(String) get getEmail => email.sink.add;  
  Function(String) get getContact => contact.sink.add;  
  Function(String) get getAddress => address.sink.add;  
  Function(String) get getDOB => dob.sink.add;  
  Function(String) get getRollNo => rollno.sink.add;  
  Function(String) get getCourse => course.sink.add;
  Function(String) get getYear => year.sink.add;    
  
   updateProfile()
  {
    Future<String> resp;  
    resp = repository.updateProfileData(firstname.value,lastname.value,email.value,contact.value,address.value,dob.value,rollno.value,course.value,year.value);
    return resp;
    
  }

  dispose() 
  {
    firstname.close();
    lastname.close();
    email.close();
    contact.close();
    address.close();
    dob.close();
    rollno.close();
    course.close();
    year.close();
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
}
final profileBloc = ProfileBloc();