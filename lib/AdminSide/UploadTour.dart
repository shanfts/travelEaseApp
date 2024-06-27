import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';

class UploadTour extends StatefulWidget {
  UploadTour({Key? key}) : super(key: key);

  @override
  State<UploadTour> createState() => _UploadTourState();
}

class _UploadTourState extends State<UploadTour> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController itineraryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  String tourType = 'Person'; // Default value for tour type
  bool hasDiscount = false;
  double discountPercentage = 0;
  double costAfterDiscount = 0;
  bool isLoading = false;

  void updateCostAfterDiscount() {
    double cost = double.tryParse(costController.text) ?? 0;
    if (hasDiscount) {
      costAfterDiscount = cost - (cost * (discountPercentage / 100));
    } else {
      costAfterDiscount = cost;
    }
    setState(() {});
  }

  Future getImage() async {
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

  Future<void> saveTour() async {
    setState(() {
      isLoading = true;
    });

    // Check if an image is selected
    if (_image == null) {
      print('No image selected.');
      setState(() {
        isLoading = false;
      });
      return;
    }

    // Calculate cost after discount
    if (hasDiscount) {
      double cost = double.tryParse(costController.text) ?? 0;
      costAfterDiscount = cost - (cost * (discountPercentage / 100));
    } else {
      costAfterDiscount = double.tryParse(costController.text) ?? 0;
    }

    try {
      // Upload image to Firebase Storage
      String fileName = _image!.path.split('/').last;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('tour_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask;

      // Get image URL from Firebase Storage
      String imageURL = await storageReference.getDownloadURL();

      // Create a new document in "tours" collection
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference tourRef = await firestore.collection('tours').add({
        'imageURL': imageURL,
        'title': titleController.text,
        'placeName': placeController.text,
        'description': descriptionController.text,
        'itinerary': itineraryController.text,
        'dates': dateController.text,
        'departureCity': cityController.text,
        'costPerPerson': costController.text,
        'tourType': tourType,
        'hasDiscount': hasDiscount,
        'discountPercentage': discountPercentage,
        'costAfterDiscount': costAfterDiscount,
        'createdAt': Timestamp.now(),
      });

      // Log the ID of the newly created document
      print('Tour uploaded with ID: ${tourRef.id}');

      // Show success toast
      Utils().toastMessage(
        message: 'Tour Uploaded Successfully',
        backgroundColor: Colors.green,
      );

      // Navigate back after success
      Navigator.pop(context);
    } catch (e) {
      // Handle errors and show error toast
      print('Error uploading tour: $e');
      Utils().toastMessage(
        message: 'Error uploading tour: $e',
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> saveTour() async {
  //   // Check if an image is selected
  //   if (_image == null) {
  //     print('No image selected.');
  //     return;
  //   }

  //   // Calculate cost after discount
  //   if (hasDiscount) {
  //     double cost = double.tryParse(costController.text) ?? 0;
  //     costAfterDiscount = cost - (cost * (discountPercentage / 100));
  //   } else {
  //     costAfterDiscount = double.tryParse(costController.text) ?? 0;
  //   }

  //   // Upload image to Firebase Storage
  //   try {
  //     // Access Firebase Storage instance
  //     String fileName =
  //         _image!.path.split('/').last; // Extract file name from path
  //     Reference storageReference =
  //         FirebaseStorage.instance.ref().child('tour_images/$fileName');
  //     UploadTask uploadTask = storageReference.putFile(_image!);
  //     await uploadTask;

  //     // Get image URL from Firebase Storage
  //     String imageURL = await storageReference.getDownloadURL();

  //     // Access Firestore instance
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;

  //     // Create a new document in "tours" collection
  //     DocumentReference tourRef = await firestore.collection('tours').add({
  //       'imageURL': imageURL,
  //       'title': titleController.text,
  //       'placeName': placeController.text,
  //       'description': descriptionController.text,
  //       'itinerary': itineraryController.text,
  //       'dates': dateController.text,
  //       'departureCity': cityController.text,
  //       'costPerPerson': costController.text,
  //       'tourType': tourType,
  //       'hasDiscount': hasDiscount,
  //       'discountPercentage': discountPercentage,
  //       'costAfterDiscount': costAfterDiscount,
  //       'createdAt': Timestamp.now(),
  //     });

  //     // Log the ID of the newly created document
  //     print('Tour uploaded with ID: ${tourRef.id}');

  //     // Navigate back and show toast message
  //     Navigator.pop(context);
  //     Utils().toastMessage(
  //       message: 'Tour Uploaded Successfully',
  //       backgroundColor: Colors.green,
  //     );
  //     // Show toast message here
  //   } catch (e) {
  //     // Handle errors
  //     print('Error uploading tour: $e');
  //     // Show toast message for error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFC5DDFF),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
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
              'Upload New Tour',
              style: TextStyle(
                color: Color(0xff323643),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Image From Gallery:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: getImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.upload_file,
                        size: 40,
                      ),
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
                SizedBox(height: 20),
                Text(
                  'Title:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Place name:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: placeController,
                  decoration: InputDecoration(
                    hintText: 'Enter place name',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: descriptionController,
                  maxLines: null, // Allow multiple lines
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Detailed Itinerary:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: itineraryController,
                  maxLines: null, // Allow multiple lines
                  decoration: InputDecoration(
                    hintText: 'Enter detailed itinerary',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Dates:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: dateController,
                  maxLines: null, // Allow multiple lines
                  decoration: InputDecoration(
                    hintText: 'Enter Dates',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Departure City :',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: 'Enter city',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Per Person Cost :',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: costController,
                  decoration: InputDecoration(
                    hintText: 'Enter Cost per person',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Tour Type:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: tourType,
                  onChanged: (String? value) {
                    setState(() {
                      tourType = value!;
                    });
                  },
                  items: <String>['Person', 'Couple']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Discount Available?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff323643),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Checkbox(
                      value: hasDiscount,
                      onChanged: (bool? value) {
                        setState(() {
                          hasDiscount = value ?? false;
                          // Reset discount percentage and cost after discount
                          if (!hasDiscount) {
                            discountPercentage = 0;
                            costAfterDiscount =
                                double.tryParse(costController.text) ?? 0;
                          }
                        });
                      },
                    ),
                  ],
                ),
                if (hasDiscount) ...[
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Discount Percentage:',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff323643),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              discountPercentage = double.tryParse(value) ?? 0;
                              updateCostAfterDiscount(); // Call this function to update costAfterDiscount
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter percentage',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 20),
                Text(
                  'Cost After Discount:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff323643),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$$costAfterDiscount',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
                // Update the onPressed assignment
                CustomButton(
                  buttonText: isLoading ? 'Loading...' : 'Save',
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true; // Show loading
                          });

                          try {
                            await saveTour(); // Call saveTour asynchronously
                          } catch (e) {
                            // Handle error if necessary
                          } finally {
                            setState(() {
                              isLoading =
                                  false; // Hide loading after saving or error
                            });
                          }
                        },
                ),

                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
