import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5DDFF),
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: const Color(0xFFC5DDFF),
        // Customize your app bar color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Heading
            Text(
              'Welcome to TravelEase',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Introduction Paragraph
            Text(
              'TravelEase is your trusted companion for discovering the world through personalized tour experiences. We believe that travel is not just about visiting new places, but about creating unforgettable memories that last a lifetime. Our mission is to provide you with a seamless, hassle-free, and enjoyable travel experience tailored to your preferences and needs.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Who We Are Heading
            Text(
              'Who We Are',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Who We Are Paragraph
            Text(
              'At TravelEase, we are a passionate team of travel enthusiasts dedicated to helping you explore the world in the most convenient and enjoyable way possible. Our expertise spans across curating diverse tour packages, offering exceptional customer support, and ensuring that your travel plans are smooth and delightful from start to finish.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // What We Offer Heading
            Text(
              'What We Offer',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // List of Services
            Text(
              '• Personalized Tour Packages: Whether you’re planning a solo adventure, a romantic getaway, or a family vacation, we have the perfect tour packages to suit your needs. Choose from a variety of options including single tours, couple tours, and family packages, all designed to provide unique and enriching experiences.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• Easy Tour Booking: Booking your dream tour is just a few clicks away. Simply search for tours by name, destination, or your favorite spots. Our intuitive booking system allows you to find the perfect tour that matches your interests and schedule.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• Secure Payment Options: We prioritize your security and convenience. You can book your tour by uploading a screenshot of your payment directly through the app, ensuring a quick and secure transaction process.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• Favorites & Recommendations: Keep track of the tours you love by adding them to your favorites list. Our app also provides recommendations based on your interests and past bookings, making it easier for you to discover new and exciting destinations.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• User-Friendly Interface: Our app is designed with you in mind. Enjoy a seamless and intuitive user experience with easy navigation, clear tour descriptions, and instant booking confirmations.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• Comprehensive Support: Need help or have a question? Our support team is available through WhatsApp for instant assistance. Whether you need help with bookings, payments, or tour information, we\'re here to support you every step of the way.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• Community & Connections: Join a community of travelers who share your passion for exploration. Connect with fellow travelers, share your experiences, and get inspired by their journeys.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 10),
            Text(
              '• User Account Management: Manage your travel plans with ease. Sign up and log in to your profile to view your bookings, payment history, and personal preferences. Customize your experience and enjoy personalized service tailored to your travel needs.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Our Commitment Heading
            Text(
              'Our Commitment',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF323643),
              ),
            ),
            SizedBox(height: 10),

            // Commitment Paragraph
            Text(
              'At TravelEase, your satisfaction is our priority. We are committed to providing you with the highest level of service, from the moment you start planning your trip until you return home with cherished memories. Our goal is to make travel accessible, enjoyable, and unforgettable for everyone.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
            ),
            SizedBox(height: 20),

            // Contact Us Heading
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22,
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
