import 'package:flutter/services.dart';
import 'package:travel_ease/Utils/ScreenSizes.dart';

import '../constants.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFC5DDFF), // Set status bar color
    ));
    return Scaffold(
      backgroundColor: const Color(0xFFC5DDFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: const Color(0xFFC5DDFF),
          leading: IconButton(
            icon: Image.asset(
              "images/back.png",
              height: 70 * SizeConfig.heightRef,
              width: 70 * SizeConfig.widthRef,
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
            ), // Customize your drawer icon here
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Languages',
            style: TextStyle(
                color: Color(0xff323643), fontWeight: FontWeight.bold),
          ),
          centerTitle: true, // Center the title
        ),
      ),
      // No AppBar is defined here, so the screen will not have an AppBar.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Radio<String>(
                  value: 'English',
                  groupValue: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
                title: const Text('English'),
              ),
              // You can add more language options here
            ],
          ),
        ),
      ),
    );
  }
}
