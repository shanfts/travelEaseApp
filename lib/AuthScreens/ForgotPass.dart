// ignore_for_file: prefer_const_constructors

import '../constants.dart';

class ForgotPassScreen extends StatefulWidget {
  ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  var text;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String email = '';
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
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Image.asset(
                        "images/back.png",
                        height: 20,
                        width: 30,
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Forgot Passord ?',
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
                    'Enter your email to get reset password link',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff606470),
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
                          Icons.email_outlined,
                          color: Color(0xff606470),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
                                color: Color(0xff606470),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                Utils().toastMessage(
                                  message: 'Please enter an email',
                                  backgroundColor: Colors.red,
                                );
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                Utils().toastMessage(
                                  message: 'Please enter a valid email',
                                  backgroundColor: Colors.red,
                                );
                              }
                              return null;
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: 'Send',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If validation passes, send password reset email
                        sendResetEmail();
                      }
                    },
                    // onPressed: () {
                    // },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "images/forgot.png",
                    height: 300,
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendResetEmail() {
    String email = emailController.text.trim();
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      // Email sent successfully
      Utils().toastMessage(
        message: 'Successfully sent password reset email',
        backgroundColor: Colors.green,
      );
      Get.to(() => CongratScreen());
    }).catchError((onError) {
      // Error sending email
      Utils().toastMessage(
        message: onError.toString(),
        backgroundColor: Colors.red,
      );
    });
  }
}
