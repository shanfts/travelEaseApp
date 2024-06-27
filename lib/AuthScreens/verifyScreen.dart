import 'dart:async';

import 'package:travel_ease/UserSide/BottomBar.dart';

import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class verifyScreen extends StatefulWidget {
  const verifyScreen({super.key});

  @override
  State<verifyScreen> createState() => _verifyScreenState();
}

class _verifyScreenState extends State<verifyScreen> {
  Timer? timer;
  bool isEmailVerified = false;
  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
      //   user = auth.currentUser;
      //   user!.sendEmailVerification();
      // timer= Timer.periodic(Duration(seconds: 3), (timer) {

      //    });
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      //  Get.to(Home());
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Text('Error');
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MyHomePage()
      : Scaffold(
          backgroundColor: Color(0xFFC5DDFF),
          body: Center(
            child: Container(
              width: 330,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    "images/logo.png",
                    height: 190,
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text(
                      'Verification has been sent to your mail, Please click the link and verify. Please do not close the app during verification. Thanks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
