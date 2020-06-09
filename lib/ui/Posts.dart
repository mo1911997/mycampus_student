import 'package:flutter/material.dart';
import 'package:placement_app/ui/Dashboard.dart';
import 'package:placement_app/ui/PostDetails.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        endDrawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.blueAccent),
          child: SizedBox(
            width: 200,
            child: Drawer(
                child: Column(
              children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text('Filters',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30.0),)
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('One',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: Colors.black,
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('One',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: Colors.black,
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('One',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: Colors.black,
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('One',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
              ],
            )),
          ),
        ),
        appBar: AppBar(
          title: Text('Posts',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: Colors.blueAccent,
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext ctxt, int index) {
              return Card(
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (_, __, ___) => PostDetails(index)));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Row(
                        children: <Widget>[
                          Hero(
                            tag: 'dash$index',
                            child: Image.network("https://picsum.photos/200/300"),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Post ' + (index + 1).toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            }),
      ),
    );
  }
}
