import '../constants.dart';

class Utils {
  void toastMessage({
    required String message,
    Color? backgroundColor,
    double duration = 0.5,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: duration.toInt(),
      backgroundColor: backgroundColor ??
          Color(0xFF58BE3F), // Use provided color or default color
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
