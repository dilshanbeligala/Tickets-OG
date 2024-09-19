
import 'error_barrel.dart';

class ErrorHandler {
  /// Error titles
  static const String TITLE_ERROR = "Error";
  static const String TITLE_OOPS = "Oops!";
  static const String TITLE_SUCCESS = "Success";
  static const String TITLE_UPDATE = "Update";
  static const String TITLE_QUESTION = "Confirm";
  static const String TITLE_FAILED = "Failed";
  static const String TITLE_NOT_VERIFIED = "Not Verified";
  static const String TITLE_SERVER_ERROR = "Unable to Connect to the Server";
  static const String TITLE_AUTHENTICATION_ERROR = "Authentication Error";
  static const String TITLE_INCORRECT_PASSWORD = "Incorrect Password";
  static const String TITLE_INCORRECT_EMAIL = "Incorrect Email";
  static const String TITLE_ALLREADY_REGISTERED = "Email is already registered";

  /// Error messages
  static const String errorSomethingWentWrong = "Connection could not be made. Please try again later.";
  static const String errorAppVerificationFailed = "Bad Credentials!";
  static const String errorMessage1 = "Entered passwords do not match";
  static const String errorMessage2 = "Invalid details. Please enter correct email and password";
  static const String errorMessageAlreadyExistingUserName = "Username already exists, try a different one";


  static const String defaultTitle = TITLE_ERROR;


  Map<String, String> mapFailureToTitleAndMessage(Failure failure) {
    if (failure is ConnectionFailure) {
      return {
        'title': TITLE_OOPS,
        'message': 'No internet connection detected.'
      };
    } else if (failure is ServerFailure) {
      final serverFailure = failure;
      return {
        'title': serverFailure.errorResponse.errorTitle ?? TITLE_SERVER_ERROR,
        'message': serverFailure.errorResponse.errorDescription ?? errorSomethingWentWrong
      };
    } else if (failure is AuthorizedFailure) {
      final authFailure = failure;
      return {
        'title': authFailure.errorResponse.errorTitle ?? TITLE_FAILED,
        'message': authFailure.errorResponse.errorDescription ?? errorSomethingWentWrong
      };
    } else {
      return {
        'title': TITLE_ERROR,
        'message': 'Unexpected error'
      };
    }
  }


}
