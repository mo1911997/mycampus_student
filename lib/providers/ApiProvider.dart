import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:placement_app/utilities/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider 
{
  //Login API 
 Future<String> checkLogin(var contact,var password) async
  {
    print(contact);
    print(password);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    http.Response response = await http.post(Constants.BASE_URL+'students/login',
    body:  {
      'contact' : contact,
      'password' : password
    });
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      {
        var storage =  new FlutterSecureStorage();
        await storage.write(key: "token",value: decodedResponse['token']);
        await sharedPreferences.setString("name", decodedResponse['name']);
        await sharedPreferences.setString("id", decodedResponse['id']);
        return "success";
      }
      else 
      {
        return decodedResponse['msg'];
      }
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
  //Change Password ( Get Contact ) API
  Future<String> changePasswordGetContact(var contact) async
  {
    print(contact);
    http.Response response = await http.post(Constants.BASE_URL+'students/get_contact_update_password',
    body:  {
      'contact' : contact,      
    });
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      {
        return 'success';
      }
      else 
      {
        return decodedResponse['msg'];
      }
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
  //Change Password ( Verify OTP ) API
  Future<String> changePasswordVerifyOTP(var contact,var otp) async
  {
    print(contact);
    print(otp);
    http.Response response = await http.post(Constants.BASE_URL+'students/verify_otp_update_password',
    body:  {
      'contact' : contact,      
      'otp' : otp
    });
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success') 
      {
        return 'success';
      }
      else 
      {
        return decodedResponse['msg'];
      }
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
  //Confirm Password API
  Future<String> changePasswordConfirmation(var contact,var password) async
  {
    print(contact);
    http.Response response = await http.post(Constants.BASE_URL+'students/update_password',
    body:  {
      'contact' : contact,      
      'password' : password
    });
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success') 
      {
        return 'success';
      }
      else 
      {
        return decodedResponse['msg'];
      }
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
  //Register Student API
  Future<String> studentRegistration(var fname,var lname,var email,var contact,var address,var dob,var courseid,var year,var rollno,var instituteid,var password) async 
  {
    
    print(fname+lname+contact+email+address+year.toString()+dob+courseid.toString()+rollno+instituteid+password);
    http.Response response = await http.post(Constants.BASE_URL+'students/add_student',
    body:  {
      'first_name':fname,
      'last_name' : lname,
      'email' : email,
      'address':address,
      'contact' : contact,
      'password' : password,
      'institute_code': instituteid,
      'dob':dob,
      'year':year,
      'roll_no':rollno,
      'course_id':courseid
    });
    print(response.body);
    if(response.statusCode == 200)
    {
       return "success";
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    } 
  }
  //API for getting all the courses for a particular institute 
  Future<List> getCourses(var code) async 
  {  
    http.Response response = await http.post(Constants.BASE_URL+'courses/get_courses_student',      
    body: {
      'institute_id': code
    }); 
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      {        
        return decodedResponse['data'];

      }
      else 
      {
        return [];
      }
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
  Future<List> getCoursesUpdateProfile() async 
  {  
    var storage = FlutterSecureStorage();
    var token = await storage.read(key: "token");
    http.Response response = await http.get(Constants.BASE_URL+'courses/get_courses_update_profle',      
    headers: {
      'Authorization':'Bearer '+ token
    }); 
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      {        
        return decodedResponse['data'];

      }
      else 
      {
        return [];
      }
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
  //API for getting profile details for a particular students 
   getProfileDetails() async
  {
    var token;
    var storage = FlutterSecureStorage();
    token = await storage.read(key:"token");
    print(token);
    http.Response response = await http.get(Constants.BASE_URL+'students/get_a_particular_student',      
    headers: {
      'Authorization' : 'Bearer '+token
    }); 
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      {
        return decodedResponse['data'];
      }
      else 
      {
        return [];
      }
    }
    else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
  getMessages() async 
  {
    http.Response response = await http.get(Constants.BASE_URL+'messages/get_messages'); 
    print(response.body);
    if(response.statusCode == 200 )
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      {
        return decodedResponse['data'];
      }
      else 
      {
        return [];
      }
    }
     else 
    {
      throw Exception('Cannot perform the operation !');
    }
  }
 Future<String> updateProfileData(firstname,lastname,email,contact,address,dob,rollno,course,year) async 
  {
    print(firstname+lastname+email+contact+address+dob+rollno+year+course);
    var storage =  FlutterSecureStorage();
    var token = await storage.read(key: "token");
    http.Response response = await http.post(Constants.BASE_URL+'students/update_student',
    body: {
      'first_name':firstname,
      'last_name':lastname,
      'contact':contact,
      'email':email,
      'address':address,
      'dob':dob,
      'roll_no':rollno,
      'course_id':course,
      'year':year
    },headers: {
      'Authorization':'Bearer '+token
    });
    print(response.body);
    if(response.statusCode == 200)
    {
      var decodedResponse = json.decode(response.body);
      if(decodedResponse['state'] == 'success')
      { 
        return "success";
      }
      else 
      {
        return "fail";
      }
    }
    else 
    {
      throw new Exception('Cannot perform the operation !');
    }
  }
}