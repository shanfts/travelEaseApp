import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ease/Utils/ScreenSizes.dart';

import '../constants.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  String? _userEmail;
  String? _userProfilePicUrl;

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
        _nameController.text = userData['name'];
        _userEmail = userData['email'];
        _userProfilePicUrl = userData['profilepic']; // Fetching profile pic URL
      });
    }
  }

  Future<void> getImage() async {
    // Check if permission is granted
    if (await Permission.storage.request().isGranted) {
      // Permission is granted, proceed with image selection
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } else {
      // Permission is not granted
      print('Permission not granted to access gallery.');
      // You can show a dialog or message to inform the user about the permission requirement
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (_image == null) return;

    try {
      String fileName =
          _image!.path.split('/').last; // Extract file name from path
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask;

      // Get image URL from Firebase Storage
      String imageURL = await storageReference.getDownloadURL();

      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update user profile picture URL and name in the users collection
        await firestore.collection('users').doc(user.uid).update({
          'profilepic': imageURL,
          'name': _nameController.text,
        });

        Utils().toastMessage(
          message: 'User data Updated Successfully',
          backgroundColor: Colors.green,
        );

        print(
            'Image uploaded and URL saved to Firestore, and username updated');

        setState(() {
          _userProfilePicUrl = imageURL;
        });
      }
    } catch (e) {
      print('Error uploading image or updating username: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5DDFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: const Color(0xFFC5DDFF),
          leading: IconButton(
            icon: Image.asset(
              "images/back.png",
              height: 70,
              width: 70,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Settings',
            style: TextStyle(
                color: Color(0xff323643), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 250 * SizeConfig.heightRef,
                      height: 250 * SizeConfig.heightRef,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.grey[200],
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
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.grey[200],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: getImage,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20 * SizeConfig.heightRef),
                Center(
                  child: Container(
                    height: 60 * SizeConfig.heightRef,
                    width: 300 * SizeConfig.widthRef,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        'Email: $_userEmail',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18 * SizeConfig.fontRef,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20 * SizeConfig.heightRef),
                if (_nameController.text.isNotEmpty && _userEmail != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20 * SizeConfig.heightRef),
                      Text(
                        'User name:',
                        style: TextStyle(
                          fontSize: 20 * SizeConfig.fontRef,
                          color: Color(0xff323643),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter new user name',
                        ),
                      ),
                      SizedBox(height: 150 * SizeConfig.heightRef),
                      CustomButton(
                        buttonText: 'Update user',
                        onPressed: uploadImageToFirebase,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
