String validateName(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

String validatePhoneNum(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Phone Number is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Phone Number must be in digit";
  } else if (value.length != 10 && value.length != 11) {
    return "Phone Number must be 10 - 11 digits";
  }
  return null;
}

String validatePassword(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Password is Required";
  } else if (value.length != 8 && value.length < 8) {
    return "Password length must be 8 characters or more";
  } else if (!regExp.hasMatch(value)) {
    return "Password must be in combination of 1 lowercase, \n1 uppercase and 1 number";
  }
  return null;
}
