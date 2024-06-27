// ignore_for_file: prefer_const_constructors

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var text;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      RefreshIndicatorState;
    });
  }

  String email = '';
  String password = '';
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
                    height: 80,
                  ),
                  Image.asset(
                    "images/logo.png",
                    height: 190,
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 70,
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
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Color(0xff606470),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
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
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color(0xff606470),
                              ),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.length < 6 && email.isNotEmpty) {
                                Utils().toastMessage(
                                  message: 'Please Enter a Password',
                                  backgroundColor: Colors
                                      .red, // Pass your desired background color here
                                );
                              }
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot password screen
                        Get.to(() => ForgotPassScreen());
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF606470),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomButton(
                    buttonText: 'Login',
                    onPressed: () async {
                      // Print the values of variables for verification
                      print('Email: $email');
                      print('Password: $password');
                      // Call the signup method directly
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          // Call the signup method
                          AuthServices.signinUser(email, password, context);

                          //  Get.off(()=> ChossScreen());
                        }
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
                        '  New User?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF606470),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Forgot password screen
                          Get.to(() => SignUpScreen());
                        },
                        child: Text(
                          'Sign up for a new account',
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
