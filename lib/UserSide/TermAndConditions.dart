import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5DDFF),
      appBar: AppBar(
        title: Text('Terms & Conditions'),
        backgroundColor: const Color(0xFFC5DDFF),
        // Customize your app bar color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction Heading
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Introduction Paragraph
            Text(
              'Welcome to TravelEase. These terms and conditions outline the rules and regulations for the use of our app. By accessing and using our app, you accept and agree to be bound by these terms. If you disagree with any part of these terms, please do not use our app.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Use of App Heading
            Text(
              '1. Use of App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Use of App Paragraph
            Text(
              '1.1 By using our app, you warrant that you are at least 18 years old and that you agree to comply with these terms. You agree not to use the app for any unlawful purpose and to comply with all applicable laws and regulations.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Account Creation Heading
            Text(
              '2. Account Creation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Account Creation Paragraph
            Text(
              '2.1 When you create an account with us, you must provide accurate and complete information. You are responsible for maintaining the confidentiality of your account and password and for restricting access to your account. You agree to accept responsibility for all activities that occur under your account.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Bookings Heading
            Text(
              '3. Bookings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Bookings Paragraph
            Text(
              '3.1 To book a tour through our app, you must provide accurate and up-to-date information. The booking confirmation will be sent to your registered email address. Payment details are securely handled by our payment processor, and we do not store your credit card information.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // User Responsibilities Heading
            Text(
              '4. User Responsibilities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // User Responsibilities Paragraph
            Text(
              '4.1 You agree to use the app only for lawful purposes and in accordance with these terms. You agree not to disrupt the functioning of the app or interfere with other users\' use of the app. You are solely responsible for your interactions with other users and for any content you post or upload to the app.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Limitation of Liability Heading
            Text(
              '5. Limitation of Liability',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Limitation of Liability Paragraph
            Text(
              '5.1 To the fullest extent permitted by applicable law, TravelEase shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from your access to or use of or inability to access or use the app.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Changes to Terms & Conditions Heading
            Text(
              '6. Changes to Terms & Conditions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Changes to Terms & Conditions Paragraph
            Text(
              '6.1 We may update our Terms & Conditions from time to time. We will notify you of any changes by posting the new Terms & Conditions on this page. You are advised to review these Terms & Conditions periodically for any changes. Changes to these Terms & Conditions are effective when they are posted on this page.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Contact Us Heading
            Text(
              '7. Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Contact Information
            Text(
              'For more information or assistance, feel free to reach out to us through our support channels. We\'re here to help you make the most of your travel experiences.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• Email: support@travelease.com',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• WhatsApp: [Chat with us](https://wa.me/your-number)',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• Website: www.travelease.com',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
          ],
        ),
      ),
    );
  }
}
