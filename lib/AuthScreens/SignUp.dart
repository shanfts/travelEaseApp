// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:travel_ease/AuthServises.dart/authFun.dart';
import 'package:travel_ease/Utils/Utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var text;
  final _formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();
  final phoneNumberController = TextEditingController();
  int currentStep = 0;
  @override
  void initState() {
    countryController.text = "+92";
    super.initState();
    setState(() {
      RefreshIndicatorState;
    });
  }

  bool _isPasswordVisible = false;
  String email = '';
  String password = '';
  String fullname = '';
  String number = '';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFC5DDFF),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF323643),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, -7), // Move shadow up
                          blurRadius: 5,
                          spreadRadius:
                              1, // Spread radius is negative for inner shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Color(0xff606470),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            key: const ValueKey('fullname'),
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                color: Color(0xff606470),
                              ),
                              border: InputBorder.none,
                            ),

                            keyboardType: TextInputType.name,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter(
                                  RegExp(r'[a-zA-Z]+|\s'),
                                  allow: true)
                            ], // Only numbers can be entered
                            validator: (value) {
                              if (value!.isEmpty) {
                                Utils().toastMessage(
                                  message: 'Please Enter Full Name',
                                  backgroundColor: Colors
                                      .red, // Pass your desired background color here
                                );
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                fullname = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, -7), // Move shadow up
                          blurRadius: 5,
                          spreadRadius:
                              1, // Spread radius is negative for inner shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Color(0xff606470),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextFormField(
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty && fullname.isNotEmpty) {
                                Utils().toastMessage(
                                  message: 'Please Enter Phone Number',
                                  backgroundColor: Colors
                                      .red, // Pass your desired background color here
                                );
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 20,
                          height: 60,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: phoneNumberController,
                            onChanged: (value) {
                              number = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Utils().toastMessage(
                                  message: 'Please enter number',
                                  backgroundColor: Colors.red,
                                );
                                // return 'Please enter phone number';
                              } else if (value.length != 10) {
                                Utils().toastMessage(
                                  message: 'Phone number must be 10 digits',
                                  backgroundColor: Colors.red,
                                );
                                // return 'Phone number must be 10 digits';
                              } else if (value.length > 10) {
                                Utils().toastMessage(
                                  message: 'Phone number must be 10 digits',
                                  backgroundColor: Colors.red,
                                );
                                // return 'Phone number must be 10 digits';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone Number",
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 60.0,
                  //   padding: EdgeInsets.symmetric(horizontal: 30.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(40.0),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.25),
                  //         offset: Offset(0, -7), // Move shadow up
                  //         blurRadius: 5,
                  //         spreadRadius:
                  //             1, // Spread radius is negative for inner shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child: Row(
                  //     children: [
                  // Icon(
                  //   Icons.phone_outlined,
                  //   color: Color(0xff606470),
                  // ),

                  //       Expanded(
                  //         flex: 3,
                  //         child: Container(
                  //           height: 30, // Set the desired height
                  //           width: double.infinity, // Set the desired width

                  //           child: IntlPhoneField(
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none, // Remove the border
                  //               labelText: 'Phone Number',
                  //             ),
                  //             initialCountryCode: 'IN',
                  //             onChanged: (phone) {
                  //               print(phone.completeNumber);
                  //             },
                  //           ),
                  //         ),
                  //       ),

                  //       // Expanded(
                  //       //   flex: 3,
                  //       //   child: TextFormField(
                  //       //     key: ValueKey('number'),
                  //       //     keyboardType: TextInputType.number,
                  //       //     decoration: InputDecoration(
                  //       //       hintText: 'Phone Number',
                  //       //       hintStyle: TextStyle(
                  //       //         color: Color(0xff606470),
                  //       //       ),
                  //       //       border: InputBorder.none,
                  //       //     ),
                  //       //     // Only numbers can be entered
                  //       //     validator: (value) {
                  //       //       if (value!.isEmpty && fullname.isNotEmpty) {
                  //       //         Utils().toastMessage(
                  //       //           message: 'Please Enter Phone Number',
                  //       //           backgroundColor: Colors
                  //       //               .red, // Pass your desired background color here
                  //       //         );
                  //       //       }
                  //       //     },
                  //       //     onSaved: (value) {
                  //       //       setState(() {
                  //       //         number = value!;
                  //       //       });
                  //       //     },
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 30.0),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, -7), // Move shadow up
                          blurRadius: 5,
                          spreadRadius:
                              1, // Spread radius is negative for inner shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Color(0xff606470),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Color(0xff606470),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty &&
                                  fullname.isNotEmpty &&
                                  number.isNotEmpty &&
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                Utils().toastMessage(
                                  message: 'Please Enter an Email',
                                  backgroundColor: Colors
                                      .red, // Pass your desired background color here
                                );
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                email = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, -7), // Move shadow up
                          blurRadius: 5,
                          spreadRadius:
                              1, // Spread radius is negative for inner shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Color(0xff606470),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            key: const ValueKey('password'),
                            // controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color(0xff606470),
                              ),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xff606470),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty &&
                                  fullname.isNotEmpty &&
                                  number.isNotEmpty &&
                                  email.isNotEmpty) {
                                Utils().toastMessage(
                                  message: 'Please Enter a Password',
                                  backgroundColor: Colors.red,
                                );
                                return 'Please Enter a Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                password = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                    buttonText: 'Sign up',
                    onPressed: () async {
                      // Print the values of variables for verification
                      print('Email: $email');
                      print('Password: $password');
                      print('Fullname: $fullname');
                      print('Number: $number');

                      // Call the signup method directly
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Call the signup method
                        AuthServices.signupUser(
                            email, password, fullname, number, context);
                        //  Get.off(()=> ChossScreen());
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a user ?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF606470),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());

                          // Forgot password screen
                        },
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff3277D8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
