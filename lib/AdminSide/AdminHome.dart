import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_ease/AdminSide/UploadTour.dart';
import 'package:travel_ease/AdminSide/UserManage.dart';
import '../constants.dart'; // assuming you have your constants imported here

class AdminScreen extends StatefulWidget {
  AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFC5DDFF), // Set status bar color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFC5DDFF),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(70), // specify the height of the app bar
          child: AppBar(
            backgroundColor:
                Color(0xFFC5DDFF), // same as scaffold background color
            elevation: 0, // remove default shadow
            title: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/logo.png",
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Text(
                        'Welcome Admin',
                        style: TextStyle(
                          color: Color(0xff3277D8),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: false,
            automaticallyImplyLeading: false, // remove back button
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Color(0xff3277D8),
                ),
                SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    height: 230,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality for first button
                        Get.to(() => UserManagement());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xff3277D8), // specify the background color
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/admin1.png",
                            height: 150,
                            width: 300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'User Managements',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // specify the text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    height: 230,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => UploadTour());
                        // Add functionality for first button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xff3277D8), // specify the background color
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/admin.png",
                            height: 150,
                            width: 300,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Upload New Tour',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // specify the text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: Container(
                    height: 60,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntroScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xff3277D8), // specify the background color
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 30,
                            color: Colors.white, // specify the icon color
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white, // specify the text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
