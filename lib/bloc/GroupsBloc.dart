
import 'package:flutter/material.dart';
import 'package:placement_app/repositories/Repository.dart';
import 'package:rxdart/rxdart.dart';

class GroupsBloc 
{
  Repository repository = Repository();  
      
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
  //  socketClient(manager,socket,messages) async {
  //   manager = new SocketIOManager();
  //   socket = await manager.createInstance(
  //       SocketOptions('https://vast-chamber-71682.herokuapp.com/'));
  //   socket.onConnect((data) {
  //     print("connected...");
  //     print(data);
  //     socket.emit("message", ["Hello world!"]);
  //   });
  //   socket.on("news", (data) {
  //     //sample event
  //     print(data);
  //     messages.add(data);      
  //   });
  //   socket.connect();
  //   return messages;
  // }
}
final groupsBloc = GroupsBloc();