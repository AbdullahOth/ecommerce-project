  class Validaion {
    static final String correctEmail = "abdullah2010@gmail.com";
    static final String correctPass = "Abed123%";  
  
 static String? isValidPass(String? pass){
    if(pass==null || pass.isEmpty){
     return "Please Enter a Password";
    }
    if(pass.length <8){
     return "A Password Must Contains At Least 8 Character";
    }
    if(!pass.contains(RegExp(r'[A-Z]') )){
     return "A Password Must Contain At Least 1 Capital Letter";
    }
    if(!pass.contains(RegExp(r'[a-z]') )){
     return "A Password Must Contain At Least 1 Small Letter";
    }
    if(!pass.contains(RegExp(r'[0-9]') )){
     return "A Password Must Contain At Least 1 Number";
    }
    if(!pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]') )){
     return "A Password Must Contain At Least 1 Symbol  (Like: @, #, !)";
    }
    return null;
  }
  static String? isValidEmail(String? email){
    if(email==null || email.isEmpty){
     return "Please Enter Email";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegex.hasMatch(email)){
     return "Please Enter a Valid Email Like (example@gmail.com)";
    }
    return null;
  }
  }