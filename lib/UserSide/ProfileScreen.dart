// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:travel_ease/UserSide/AboutUs.dart';
import 'package:travel_ease/UserSide/Languages.dart';
import 'package:travel_ease/UserSide/PrivacyPolicy.dart';
import 'package:travel_ease/UserSide/Settings.dart';
import 'package:travel_ease/UserSide/TermAndConditions.dart';
import 'package:travel_ease/UserSide/Trips.dart';
import 'package:travel_ease/Utils/ScreenSizes.dart';

import '../constants.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var text;
  final _formKey = GlobalKey<FormState>();
  File? _image;
  // TextEditingController _nameController = TextEditingController();
  String? _userName;
  String? _userEmail;
  String? _userProfilePicUrl;

  List<Map<String, dynamic>> dataList = [
    {"name": "Language", "icon": Icons.language_outlined},
    {"name": "About US", "icon": Icons.announcement_outlined},
    {"name": "Privacy Policy", "icon": Icons.front_hand_outlined},
    {"name": "Term & Conditions", "icon": Icons.help_outline},
    {"name": "Log out", "icon": Icons.logout},
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _userName = userData['name'];
        _userEmail = userData['email'];
        _userProfilePicUrl = userData['profilepic']; // Fetching profile pic URL
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5DDFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: const Color(0xFFC5DDFF),
          // leading: IconButton(
          //   icon: Image.asset(
          //     "images/back.png",
          //     height: 70 * SizeConfig.heightRef,
          //     width: 70 * SizeConfig.widthRef,
          //     // height: MediaQuery.of(context).size.height,
          //     // width: MediaQuery.of(context).size.width,
          //   ), // Customize your drawer icon here
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
          title: Text(
            'Profile',
            style: TextStyle(
                color: Color(0xff323643), fontWeight: FontWeight.bold),
          ),
          centerTitle: true, // Center the title
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14 * SizeConfig.widthRef),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20 * SizeConfig.widthRef,
                  ),
                  Container(
                    width: 150 *
                        SizeConfig.heightRef, // Adjust according to your needs
                    height: 150 *
                        SizeConfig.heightRef, // Adjust according to your needs
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          75), // Half of the width or height
                      color: Colors.grey[200], // Background color
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : _userProfilePicUrl != null
                              ? Image.network(
                                  _userProfilePicUrl!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "images/tour4.png",
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  SizedBox(
                    width: 20 * SizeConfig.widthRef,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName ?? 'Guest', // Display username or 'Guest'
                        style: TextStyle(
                            fontSize: 18 * SizeConfig.fontRef,
                            color: Color(0xFF323643),
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5 * SizeConfig.heightRef,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color.fromARGB(255, 96, 97, 100),
                          ),
                          SizedBox(
                            width: 5 * SizeConfig.widthRef,
                          ),
                          Text(
                            'Pakistan',
                            style: TextStyle(
                                fontSize: 18 * SizeConfig.fontRef,
                                color: Color.fromARGB(255, 96, 97, 100),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5 * SizeConfig.heightRef,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 120 * SizeConfig.widthRef,
                            height: 40 * SizeConfig.heightRef,
                            child: MaterialButton(
                              textColor: Colors.white,
                              color: const Color(0xFF167CF4),
                              elevation: 0, // Ensure no elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                'Edit Prifle',
                                style: TextStyle(
                                  fontSize: 12 * SizeConfig.fontRef,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onPressed: () {
                                Get.to(UserSettings());
                              }, // Set onPressed to null or a function
                            ),
                          ),
                          SizedBox(
                            height: 5 * SizeConfig.widthRef,
                          ),
                          Container(
                            width: 120 * SizeConfig.widthRef,
                            height: 40 * SizeConfig.heightRef,
                            child: MaterialButton(
                              textColor: Colors.white,
                              color: Color.fromARGB(255, 38, 117, 24),
                              elevation: 0, // Ensure no elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                'My Trips',
                                style: TextStyle(
                                  fontSize: 12 * SizeConfig.fontRef,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onPressed: () {
                                Get.to(TripScreen());
                              }, // Set onPressed to null or a function
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey, // Color of the divider line
                thickness: 1, // Thickness of the divider line
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey, // Color of the bottom border
                          width: 0.8, // Thickness of the bottom border
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Navigation using Get.to()
                        switch (dataList[index]['name']) {
                          case 'Language':
                            Get.to(LanguageScreen());
                            break;
                          case 'About US':
                            Get.to(AboutUsPage());
                            break;
                          case 'Privacy Policy':
                            Get.to(PrivacyPolicyPage());
                            break;
                          case 'Term & Conditions':
                            Get.to(TermsConditionsPage());
                            break;
                          case 'Log out':
                            FirebaseAuth.instance.signOut();
                            Get.offAll(LoginScreen());
                            break;
                          default:
                            break;
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        minimumSize: Size(double.infinity,
                            70), // Set the height of the button
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                dataList[index]["icon"], // Icon
                                size: 30,
                                color: Color(0xff3277D8),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                dataList[index]["name"] ?? "", // Name
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff323643)),
                              ),
                            ],
                          ),
                          Icon(Icons.chevron_right_sharp,
                              size: 40, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
