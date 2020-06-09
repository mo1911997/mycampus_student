import 'package:placement_app/providers/ApiProvider.dart';

class Repository 
{
  ApiProvider apiProvider = ApiProvider();

  //Login
  Future<String> checkLogin(var contact,var password) => apiProvider.checkLogin(contact, password);
  //Change Password Get Contact 
  Future<String> changePasswordGetContact(var contact) => apiProvider.changePasswordGetContact(contact);
  //Change Password Verify OTP
  Future<String> changePasswordVerifyOTP(var contact,var otp) => apiProvider.changePasswordVerifyOTP(contact,otp);
  //Change Password Confirmation
  Future<String> changePasswordConfirmation(var contact,var password) => apiProvider.changePasswordConfirmation(contact,password);
  //Student Registration
  Future<String> studentRegistration(var fname,var lname,var email,var contact,var address,var dob,var courseid,var year,var rollno,var instituteid,var password) => apiProvider.studentRegistration(fname,lname,email,contact,address,dob,courseid,year,rollno,instituteid,password);
  //Update Profile Data
  Future<String> updateProfileData(firstname,lastname,email,contact,address,dob,rollno,course,year) => apiProvider.updateProfileData(firstname,lastname,email,contact,address,dob,rollno,course,year);
}