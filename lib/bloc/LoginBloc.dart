import 'package:flutter/material.dart';
import 'package:placement_app/repositories/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc 
{
  Repository repository = Repository();
  final contact = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();
  Function(String) get getContact => contact.sink.add;
  Function(String) get getPassword => password.sink.add;
  
   checkLogin()
  {
    Future<String> resp;  
    resp = repository.checkLogin(contact.value, password.value);
    return resp;
    
  }

  dispose() 
  {
    contact.close();
    password.close();
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
final loginBloc = LoginBloc();