import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
];

mixin LocaleData {
  static const String pressAgainToExit = "pressAgainToExit";
  static const String login = "login";
  static const String signInTO = "signInTO";
  static const String email = "email";
  static const String userName = "userName";
  static const String emailCantEmpty = "emailCantEmpty";
  static const String password = "password";
  static const String passwordCantEmpty = "passwordCantEmpty";
  static const String forgotPassword = "forgotPassword";
  static const String signIn = "signIn";
  static const String didntHaveAnAccount = "didntHaveAnAccount";
  static const String signUp = "signUp";
  static const String registrationSuccess = "registrationSuccess";
  static const String exploreTheApp = "exploreTheApp";
  static const String ok = "ok";
  static const String logOut = "logOut";
  static const String loginContent = "loginContent";
  static const String emailHint = "emailHint";
  static const String phoneHint = "phoneHint";
  static const String passwordHint = "passwordHint";
  static const String register = "register";
  static const String firstName = "firstName";
  static const String firstNameHint = "firstNameHint";
  static const String lastName = "lastName";
  static const String lastNameHint = "lastNameHint";
  static const String firstNameCantEmpty = "firstNameCantEmpty";
  static const String lastNameCantEmpty = "lastNameCantEmpty";
  static const String alreadyHaveAnAccount = "alreadyHaveAnAccount";
  static const String phoneNumber = "phoneNumber";
  static const String address = "address";
  static const String addressHint = "addressHint";
  static const String addressCant = "addressCant";
  static const String role = "role";
  static const String forgotPasswordTitle = "forgotPasswordTitle";
  static const String resetPassword = "resetPassword";
  static const String requestOtp = "requestOtp";
  static const String otpVerification = "otpVerification";
  static const String didntReceive = "didntReceive";
  static const String resend = "resend";
  static const String resendSuccess = "resendSuccess";
  static const String newPassword = "newPassword";
  static const String confirmPassword = "confirmPassword";
  static const String passwordsDidnt = "passwordsDidnt";
  static const String onBoardTitle = "onBoardTitle";
  static const String onBoardContent = "onBoardContent";
  static const String loginFailed = "loginFailed";




  static const Map<String, dynamic> EN = {
    pressAgainToExit: "Press again to exit",
    login: "Sign In",
    signInTO: "Sign in to TicketsOG",
    emailCantEmpty: "Email can't be empty",
    password: "Password",
    email: "E-mail",
    userName: "User name",
    passwordCantEmpty: "Password can't be empty",
    forgotPassword: "Forgot your password?",
    didntHaveAnAccount: "Don’t have an account? ",
    signUp: "Sign Up",
    registrationSuccess: "Registration Successful!",
    exploreTheApp: "Explore the app to mange your educational journey.",
    ok: "Ok",
    logOut: "Logout",
    loginContent: "Log in to continue your\neducational journey!",
    emailHint: "name@gmail.com",
    phoneHint: "Enter your phone number here",
    passwordHint: "Enter your password here",
    register: "Register",
    firstName: "First Name",
    firstNameHint: "Enter your first name here",
    lastName: "Last Name ",
    lastNameHint: "Enter your last name here",
    firstNameCantEmpty: "First name can't be empty",
    lastNameCantEmpty: "Last name can't be empty",
    alreadyHaveAnAccount: "Already have an account? ",
    phoneNumber: "Phone Number",
    address: "address",
    addressHint: "Enter your address here",
    addressCant: "Address can't empty",
    role: "Role",
    forgotPasswordTitle: "Forgot Password",
    resetPassword: "Reset Password",
    requestOtp: "Request OTP",
    otpVerification: "OTP Verification",
    didntReceive: "Didn't receive Code? ",
    resend: "Resend OTP",
    resendSuccess: "Resend OTP Success",
    newPassword: "New Password",
    confirmPassword: "Confirm New Password",
    passwordsDidnt: "Passwords didnt match",
    onBoardTitle: "Welcome to Class Q",
    onBoardContent: "Your personal guide to Educate",
    loginFailed: "Login Failed",
  };

//other language strings
}
