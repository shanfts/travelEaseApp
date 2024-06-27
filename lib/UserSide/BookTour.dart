import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming you are using GetX for navigation
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart'; // Import your CustomButton widget

class TourBookScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  TourBookScreen({required this.data});

  @override
  _TourBookScreenState createState() => _TourBookScreenState();
}

class _TourBookScreenState extends State<TourBookScreen> {
  int _personCount = 1; // Initial count
  double _totalCost = 0.0; // Variable to store the total cost
  // Variable to store the total cost
  File? _image;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _calculateTotalCost(); // Initial calculation
  }

  void _incrementCount() {
    setState(() {
      _personCount++;
      _calculateTotalCost();
    });
  }

  void _decrementCount() {
    setState(() {
      if (_personCount > 1) {
        _personCount--;
        _calculateTotalCost();
      }
    });
  }

  void _calculateTotalCost() {
    // Ensure costPerPerson is converted to double
    double costPerPerson = 0.0;
    if (widget.data["costPerPerson"] is String) {
      costPerPerson = double.parse(widget.data["costPerPerson"]);
    } else if (widget.data["costPerPerson"] is num) {
      costPerPerson = widget.data["costPerPerson"].toDouble();
    }
    _totalCost = _personCount * costPerPerson;
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

  Future<void> _uploadBooking() async {
    try {
      // Get the current user
      final User? user = _auth.currentUser;
      if (user == null) {
        print('User not logged in');
        return;
      }
      final String userId = user.uid;

      // Fetch user data from Firestore
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final String? userName = userSnapshot.exists
          ? (userSnapshot.data() != null
              ? (userSnapshot.data() as Map<String, dynamic>)['name']
              : null)
          : null;

      final String? userEmail = user.email;

      // Upload image to Firebase Storage
      String? imageUrl;
      if (_image != null) {
        final String fileName =
            'bookings/${userId}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final Reference storageRef =
            FirebaseStorage.instance.ref().child(fileName);
        final UploadTask uploadTask = storageRef.putFile(_image!);

        final TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      // Prepare booking data
      Map<String, dynamic> bookingData = {
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'tourTitle': widget.data['title'],
        'costPerPerson': widget.data['costPerPerson'],
        'placeName': widget.data["placeName"],
        'imageURLTour': widget.data["imageURL"], // Change to imageURL
        'description': widget.data["description"],
        'totalCost': _totalCost,
        'personCount': _personCount,
        'imageUrl': imageUrl ?? '',
        'timestamp': Timestamp.now(),
      };

      // Upload booking data to Firestore
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(userId)
          .collection('userBookings')
          .add(bookingData);

      print('Booking uploaded successfully');
      Navigator.pop(context);
      Utils().toastMessage(
        message: 'Tour Booked Successfully',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print('Error uploading booking: $e');
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
              Get.back();
            },
          ),
          title: Text(
            'Tour Booking',
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    widget.data["imageURL"],
                    width: double.infinity,
                    height: 380,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tour Title: ',
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  widget.data["title"],
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Divider(color: Colors.grey, thickness: 1),
                Text(
                  'Booking Method:  ',
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Direct Bank Transfer",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  "1. All instructions for transferring payment directly to our JazzCash, EasyPaisa, or Bank Account will appear on the “Thank You Page” after placing your order. Please mention your order number when sending us a screenshot of the payment transfer, you will find your order number on the “Thank You Page” and also in your email. Your order will not be shipped until the funds have cleared our account.",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  "2. Please copy any of these numbers and transfer payments.",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  "3. Please confirm this account title before transferring payment.",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  "4. Once the payment is done, save the screenshot when the transaction is successful.",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  "6. You can send us the screenshot via Submit or Whatsapp (Click on the WhatsApp button on the Screen.).",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text(
                  "7. If you have any questions regarding payment, you can contact us via Whatsapp.",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Divider(
                  color: Colors.grey, // Color of the divider line
                  thickness: 1, // Thickness of the divider line
                ),
                Text(
                  ' Our bank details: ',
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  " BANK:  Bank Name",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  " Account Title:  Bank Title",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  " ACCOUNT NUMBER:  000000000000000",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  "  IBAN:  PAKID000000000000000",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Divider(
                  color: Colors.grey, // Color of the divider line
                  thickness: 1, // Thickness of the divider line
                ),
                Text(
                  " BANK:  JAZZCASH",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  " Account Title:  Bank Title",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  " ACCOUNT NUMBER:  000000000000000",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Divider(
                  color: Colors.grey, // Color of the divider line
                  thickness: 1, // Thickness of the divider line
                ),
                Text(
                  " BANK:  JAZZCASH",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  " Account Title:  Bank Title",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  " ACCOUNT NUMBER:  000000000000000",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                // ... Other instructions and details
                Divider(color: Colors.grey, thickness: 1),
                Text(
                  'Cost Per Person: ',
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "Rs ${widget.data["costPerPerson"]}",
                  style: TextStyle(
                      color: Color(0xff323643),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Divider(color: Colors.grey, thickness: 1),
                Text(
                  'Select Persons:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _decrementCount,
                      color: Colors.red,
                      iconSize: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '$_personCount',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff323643),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _incrementCount,
                      color: Colors.green,
                      iconSize: 30,
                    ),
                  ],
                ),
                Divider(color: Colors.grey, thickness: 1),
                SizedBox(height: 20),

                Text(
                  'Total Cost: Rs $_totalCost',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Divider(color: Colors.grey, thickness: 1),
                SizedBox(height: 20),

                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      getImage();
                      // Define your onPressed action here
                      print('Upload button pressed');
                    },
                    icon: Icon(
                      Icons.upload, // Upload icon
                      color: Colors.white, // Icon color
                    ),
                    label: Text(
                      'Upload Payed Bank Receipt',
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12), // Padding inside the button
                      textStyle: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: _image != null
                      ? Container(
                          width: 330,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                15), // Adjust border radius as needed
                            image: DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
                Divider(
                  color: Colors.grey, // Color of the divider line
                  thickness: 1, // Thickness of the divider line
                ),
                SizedBox(height: 20),

                CustomButton(
                  buttonText: 'Submit Booking',
                  onPressed: () {
                    _uploadBooking();
                    // Print the values of variables for verification
                    // Add your booking logic here
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  buttonText: 'Open WhatsApp',
                  onPressed: () {
                    reachUs() async {
                      var androidNumber =
                          "+923249470845"; // Update with your Pakistani WhatsApp number

                      var androidUrl =
                          "whatsapp://send?phone=$androidNumber&text=Hi, I need some help about tour booking.";

                      var iOSNumber =
                          "+923249470845"; // Update with your Pakistani WhatsApp number

                      var iOSUrl =
                          "https://wa.me/$iOSNumber?text=${Uri.parse("Hi, I need some help tour booking.")}";

                      if (Platform.isIOS) {
                        if (await canLaunch(iOSUrl)) {
                          await launch(iOSUrl, forceSafariVC: false);
                        } else {
                          print('WhatsApp is not installed');
                        }
                      } else {
                        if (await canLaunch(androidUrl)) {
                          await launch(androidUrl);
                        } else {
                          print('WhatsApp is not installed');
                        }
                      }
                    }

                    reachUs();
                    // Print the values of variables for verification
                    // Add your booking logic here
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
