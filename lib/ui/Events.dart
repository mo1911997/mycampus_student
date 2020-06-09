import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  var _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("Events",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          centerTitle: true,
          actions: <Widget>[

        ],),
        backgroundColor: Colors.blueAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children :<Widget>[
                  Container(                   
            color: Colors.white,
            child: TableCalendar(
                
                calendarController: _calendarController,
          ),    
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height*0.30,
            
          )
          
        ] 
        )  
      ),
    );
  }
}