// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:travel_ease/AdminSide/AdminHome.dart';
import 'package:travel_ease/AuthScreens/verifyScreen.dart';
import 'package:travel_ease/Utils/Utils.dart';

import '../constants.dart';

class AuthServices {
  static signupUser(String email, String password, String name, String number,
      BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'password': password,
        'number': number,
      });
      Utils().toastMessage(
        message: 'User Registered Successfully',
        backgroundColor: Colors.green,
      );
      // Get.to(verifyScreen());
      // Reset navigation stack and navigate to HomeScreenUser
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => verifyScreen()),
      //   (route) => false, // Remove all routes from stack
      // );
      Get.offAll(verifyScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils().toastMessage(
          message: 'Please Enter a Password',
          backgroundColor: Colors.red,
        );
      } else if (e.code == 'email-already-in-use') {
        Utils().toastMessage(
          message: 'Email Provided already Exists',
          backgroundColor: Colors.red,
        );
      } else {
        Utils().toastMessage(
          message: e.toString(),
          backgroundColor: Colors.red,
        );
      }
    }
  }

//   static signinUser(String email, String password, BuildContext context) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       // If login is successful, navigate to HomeScreenUser
//       // Reset navigation stack and navigate to HomeScreenUser
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => verifyScreen()),
//         (route) => false, // Remove all routes from stack
//       );
//       // Show success message using toastMessage
//       Utils().toastMessage(
//         message: 'Login Successfully',
//         backgroundColor: Colors.green,
//       );
//     } on FirebaseAuthException catch (e) {
//       // Catch FirebaseAuthException and handle different error cases
//       if (e.code == 'wrong-password') {
//         // If user not found, show error message
//         Utils().toastMessage(
//           message: 'Password is incorrect',
//           backgroundColor: Colors.red,
//         );
//       } else if (e.code == 'network-request-failed') {
//         // If wrong password, show error message
//         Utils().toastMessage(
//           message: 'Network request Failed',
//           backgroundColor: Colors.red,
//         );
//       } else {
//         // If other FirebaseAuthException occurs, show error message
//         Utils().toastMessage(
//           message: 'Error: ${e.message}',
//           backgroundColor: Colors.red,
//         );
//       }
//     } catch (e) {
//       // Catch any other unexpected errors and show generic error message
//       Utils().toastMessage(
//         message: 'An unexpected error occurred',
//         backgroundColor: Colors.red,
//       );
//     }
//   }
// }
  static signinUser(String email, String password, BuildContext context) async {
    try {
      // Perform Firebase sign-in
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If login is successful
      if (userCredential.user != null) {
        // Retrieve the current user's email from Firebase
        String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

        // Navigate based on user's email
        if (currentUserEmail == 'admin.te@gmail.com') {
          // Navigate to admin screen
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AdminScreen(),
          //   ),
          // );
          Get.offAll(AdminScreen());
          // Show success message using toastMessage
          Utils().toastMessage(
            message: 'Admin Login Successfully',
            backgroundColor: Colors.green,
          );
        } else {
          // Navigate to verifyScreen for regular users
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => verifyScreen()),
          // );
          Get.offAll(verifyScreen());
          // Show success message using toastMessage
          Utils().toastMessage(
            message: 'Login Successfully',
            backgroundColor: Colors.green,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // Catch FirebaseAuthException and handle different error cases
      if (e.code == 'wrong-password') {
        // If user not found, show error message
        Utils().toastMessage(
          message: 'Password is incorrect',
          backgroundColor: Colors.red,
        );
      } else if (e.code == 'network-request-failed') {
        // If wrong password, show error message
        Utils().toastMessage(
          message: 'Network request Failed',
          backgroundColor: Colors.red,
        );
      } else {
        // If other FirebaseAuthException occurs, show error message
        Utils().toastMessage(
          message: 'Error: ${e.message}',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Catch any other unexpected errors and show generic error message
      Utils().toastMessage(
        message: 'An unexpected error occurred',
        backgroundColor: Colors.red,
      );
    }
  }
}
