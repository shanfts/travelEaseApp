// ignore_for_file: must_be_immutable

import '../constants.dart';

class IntroScreen extends StatelessWidget {
  var text;

  IntroScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFC5DDFF),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  'Get Ready For Travel',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF323643)),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'welcome to travel get ready',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF606470)),
                ),
                Image.asset(
                  "images/intro.png",
                  height: 430,
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 350, // <-- match_parent
                    height: 60,
                    //
                    child: MaterialButton(
                      textColor: Colors.white,
                      color: const Color(0xFF0B274E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
