// ignore_for_file: prefer_const_constructors

import '../constants.dart';

class CongratScreen extends StatefulWidget {
  CongratScreen({Key? key}) : super(key: key);

  @override
  State<CongratScreen> createState() => _CongratScreenState();
}

class _CongratScreenState extends State<CongratScreen> {
  var text;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFC5DDFF),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Image.asset(
                  "images/check.png",
                  height: 130,
                  width: 130,
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Congratulation !',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff323643),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'The password reset link has been sent to your email. Click on the link to reset your password. Thank you.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff606470),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff606470),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomButton(
                  buttonText: 'Login',
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
