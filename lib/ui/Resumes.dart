import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Resumes extends StatefulWidget {
  @override
  _ResumesState createState() => _ResumesState();
}

class _ResumesState extends State<Resumes> {
  var connectivityResult;
  var isConnectionActive = true;
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  checkInternetConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnectionActive = true;
      });
    } else {
      setState(() {
        isConnectionActive = false;
      });
    }
  }
  launchPDF(var url)async
  {
      if (await canLaunch(url)) {
      await launch(
        url,        
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return isConnectionActive == false
        ? SafeArea(
            child: Scaffold(
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('No internet connection !'),
                  RaisedButton(
                    elevation: 0.0,
                    onPressed: () {
                      checkInternetConnection();
                    },
                    child: Text('Refresh'),
                  )
                ],
              )),
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  "Resumes",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.file_upload,
                        color: Colors.white,
                      ))
                ],
              ),
              backgroundColor: Colors.blueAccent,
              body: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      launchPDF("http://docs.google.com/viewer?url=http://www.pdf995.com/samples/pdf.pdf");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Text('Resume $index'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
