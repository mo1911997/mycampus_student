import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placement_app/bloc/ProfileBloc.dart';
import 'package:placement_app/providers/ApiProvider.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  var one = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var connectivityResult;
  var resp;
  var isConnectionActive = true;
  
  ApiProvider apiProvider;
  var profileDetails;
  List profileDetails2;
  FocusNode fnameNode,
      lnameNode,
      contactNode,
      emailNode,
      dobNode,
      addressNode,
      rollnoNode,
      updateButtonNode;
      var avatarFile = NetworkImage('https://w0.pngwave.com/png/613/636/computer-icons-user-profile-male-avatar-avatar-png-clip-art.png');
  var fname = TextEditingController();
  var lname = TextEditingController();
  var contact = TextEditingController();
  var email = TextEditingController();
  var img ;
  var address = TextEditingController();
  var dropdownValueCourse;
  var dropdownValueYear = "";
  List<String> courses = [];
  List courseValues;
  var dob = TextEditingController();
  var year = TextEditingController();
  var rollNo = TextEditingController();
  var course = TextEditingController();
  @override
  void initState() {
    getProfileDetails();
    super.initState();

    checkInternetConnection();

    courseValues = [];
    profileDetails2 = [];

    fnameNode = FocusNode();
    lnameNode = FocusNode();
    contactNode = FocusNode();
    emailNode = FocusNode();
    dobNode = FocusNode();
    rollnoNode = FocusNode();
    addressNode = FocusNode();
    updateButtonNode = FocusNode();
    getCourses();
    
  }
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      img = image;
    });
  }

  getCourses() async {
    ApiProvider apiProvider = ApiProvider();
    courseValues = await apiProvider.getCoursesUpdateProfile();
    setState(() {
      for (var i in courseValues) {
        courses.add(i['name']);
      }
    });
  }

  getProfileDetails() async {
    apiProvider = ApiProvider();
    profileDetails2 = await apiProvider.getProfileDetails();
    setState(() {
      for (var i in profileDetails2) {
        fname.text = i['first_name'];
        lname.text = i['last_name'];
        address.text = i['address'];
        contact.text = i['contact'];
        email.text = i['email'];
        dob.text = i['dob'];
        dropdownValueCourse = i['course_id']['name'].toString();
        dropdownValueYear = i['year'];
        rollNo.text = i['roll_no'];
      }
    });
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
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          one = one == false ? true : false;
                        });
                      },
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.blueAccent,
              body: profileDetails2.length == 0
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      getImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: NetworkImage('https://w0.pngwave.com/png/613/636/computer-icons-user-profile-male-avatar-avatar-png-clip-art.png',scale: 3.0) ,
                                      // backgroundImage: NetworkImage(
                                      //     "https://picsum.photos/200/300"),
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['first_name']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: TextFormField(
                                              focusNode: fnameNode,
                                              cursorColor: Colors.white,
                                              style: new TextStyle(
                                                  color: Colors.white),
                                              controller: fname,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  labelText: "First Name",
                                                  labelStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['last_name']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: TextFormField(
                                              focusNode: lnameNode,
                                              cursorColor: Colors.white,
                                              style: new TextStyle(
                                                  color: Colors.white),
                                              controller: lname,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  labelText: "Last Name",
                                                  labelStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['email']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: TextFormField(
                                              focusNode: emailNode,
                                              cursorColor: Colors.white,
                                              controller: email,
                                              style: new TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  labelText: "Email",
                                                  labelStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['contact']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: TextFormField(
                                              focusNode: contactNode,
                                              cursorColor: Colors.white,
                                              controller: contact,
                                              style: new TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  labelText: "Contact",
                                                  labelStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['address']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: TextFormField(
                                              focusNode: addressNode,
                                              cursorColor: Colors.white,
                                              style: new TextStyle(
                                                  color: Colors.white),
                                              controller: address,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  labelText: "Address",
                                                  labelStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['dob']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: TextFormField(
                                              focusNode: dobNode,
                                              cursorColor: Colors.white,
                                              controller: dob,
                                              style: new TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  labelText: "DOB",
                                                  labelStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['roll_no']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: TextFormField(
                                              focusNode: rollnoNode,
                                              cursorColor: Colors.white,
                                              style: new TextStyle(
                                                  color: Colors.white),
                                              controller: rollNo,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  labelText: "Roll No",
                                                  labelStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['course_id']
                                                        ['name']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                  canvasColor:
                                                      Colors.blueAccent),
                                              child: IgnorePointer(
                                                ignoring: true,
                                                child: DropdownButton<String>(
                                                  value: dropdownValueCourse,
                                                  icon: Icon(
                                                      Icons.arrow_downward),
                                                  iconSize: 0.0,
                                                  elevation: 16,
                                                  hint: Text(
                                                    'Select Course',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                        fontFamily: 'Raleway'),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  underline: Container(
                                                    height: 1,
                                                    color: Colors.white,
                                                  ),
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      dropdownValueCourse =
                                                          newValue;
                                                      // registrationBloc.year.value = newValue;
                                                    });
                                                    return null;
                                                  },
                                                  items: courses.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Raleway'),
                                                        ));
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedCrossFade(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      crossFadeState: one == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 30.0),
                                            child: Icon(
                                                Icons.settings_input_svideo),
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                profileDetails2[0]['year']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                      secondChild: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                  canvasColor:
                                                      Colors.blueAccent),
                                              child: IgnorePointer(
                                                ignoring: true,
                                                child: DropdownButton<String>(
                                                  value: dropdownValueYear,
                                                  icon: Icon(
                                                      Icons.arrow_downward),
                                                  iconSize: 0.0,
                                                  elevation: 16,
                                                  hint: Text(
                                                    'Select Year',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                        fontFamily: 'Raleway'),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  underline: Container(
                                                    height: 1,
                                                    color: Colors.white,
                                                  ),
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      dropdownValueYear =
                                                          newValue;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'One',
                                                    'Two',
                                                    'Three',
                                                    'Four'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Raleway'),
                                                        ));
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: RaisedButton(
                              focusNode: updateButtonNode,
                              onPressed: () async {
                                profileBloc.dialogLoader(context);
                                profileBloc.firstname.value = fname.text;
                                profileBloc.lastname.value = lname.text;
                                profileBloc.email.value = email.text;
                                profileBloc.contact.value = contact.text;
                                profileBloc.address.value = address.text;
                                profileBloc.dob.value = dob.text;
                                profileBloc.rollno.value = rollNo.text;
                                for (var i in courseValues) {
                                  if (i['name'] == dropdownValueCourse) {
                                    profileBloc.course.value = i['_id'];
                                  }
                                }
                                profileBloc.year.value = dropdownValueYear;
                                resp = await profileBloc.updateProfile();
                                if (resp == "success") {
                                  FocusScope.of(context)
                                      .requestFocus(updateButtonNode);
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                          content: new Text("Profile Updated !",
                                              style: TextStyle(
                                                  fontFamily: 'Ralweway'))));
                                } else {
                                  FocusScope.of(context)
                                      .requestFocus(updateButtonNode);
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(
                                          content: new Text(
                                              "Cannot update profile !",
                                              style: TextStyle(
                                                  fontFamily: 'Ralweway'))));
                                }
                              },
                              color: Colors.blueAccent[100],
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                          duration: const Duration(microseconds: 1500),
                          crossFadeState: one == false
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        )
                      ],
                    ),
            ),
          );
  }
}
