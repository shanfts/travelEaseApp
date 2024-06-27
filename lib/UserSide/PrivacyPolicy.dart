import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5DDFF),
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: const Color(0xFFC5DDFF),
        // Customize your app bar color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'At TravelEase, we are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, and safeguard your personal information. By using our app, you agree to the collection and use of information in accordance with this policy.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),
            Text(
              'Information Collection',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We collect various types of information for different purposes to provide and improve our services. This includes information you provide directly, such as your name, email address, and payment details, as well as information collected automatically, such as your usage data and preferences.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),
            Text(
              'Use of Information',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We use the information we collect to provide and enhance our services. This includes processing bookings, personalizing your experience, providing customer support, and improving our app. We may also use your information for marketing purposes, such as sending you promotional offers and updates.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),
            Text(
              'Information Sharing',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We do not share your personal information with third parties except as necessary to provide our services or as required by law. We may share information with trusted partners who assist us in operating our app, conducting business, or serving you. These partners are required to keep your information confidential and secure.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),
            Text(
              'Data Security',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We implement a variety of security measures to ensure the safety of your personal information. Your data is stored securely and is only accessible to a limited number of individuals who have special access rights and are required to keep the information confidential.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'For more information or assistance, feel free to reach out to us at support@travelease.com. We are here to help you with any questions or concerns regarding our Privacy Policy.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
          ],
        ),
      ),
    );
  }
}
