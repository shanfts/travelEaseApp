import 'package:flutter/material.dart';
import 'package:travel_ease/Components/Button.dart';
import 'package:travel_ease/UserSide/BookTour.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure to import necessary packages

class TourDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  TourDetailScreen({required this.data});

  // WhatsApp URL launcher function
  void _openWhatsApp(String phoneNumber, String message) async {
    // Construct the WhatsApp URL
    final String whatsappUrl =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    // Check if the URL can be launched
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
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
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
            ),
            onPressed: () {
              Navigator.pop(context); // Use Navigator.pop to go back
            },
          ),
          title: Text(
            'Tour Details',
            style: TextStyle(
              color: Color(0xff323643),
              fontWeight: FontWeight.bold,
            ),
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
                    data["imageURL"] ??
                        data["imageURLTour"], // Handle potential null imageURL
                    width: double.infinity,
                    height: 380,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tour Ratings: ',
                      style: TextStyle(
                        color: Color(0xff323643),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Colors.green,
                          size: 30,
                        ),
                        Text(
                          "4.5",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 135, 138, 147),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                buildTextRow(
                    'Tour Title: ', data["title"] ?? data["tourTitle"]),
                buildTextRow('Tour description: ', data["description"]),
                buildTextRow('Tour place name: ', data["placeName"]),
                buildTextRow('Tour dates: ', data["dates"]),
                buildTextRow('Departure City: ', data["departureCity"]),
                buildTextRow('Itinerary: ', data["itinerary"]),
                buildCostPerPerson('Cost Per Person: ', data["costPerPerson"]),
                SizedBox(height: 20),
                if (data["title"] == null)
                  CustomButton(
                    buttonText: 'Add Review',
                    onPressed: () {
                      // Define the phone number and message
                      String phoneNumber =
                          '+923249470845'; // Replace with the actual phone number
                      String message =
                          'Hello! I want to submit reviews for my tour.'; // Customize your message

                      // Open WhatsApp
                      _openWhatsApp(phoneNumber, message);
                    },
                  )
                else
                  CustomButton(
                    buttonText: 'Book Tour',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TourBookScreen(data: data),
                        ),
                      );
                    },
                  ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextRow(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xff323643),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          value ?? "", // Use empty string if value is null
          style: TextStyle(
            color: Color(0xff323643),
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      ],
    );
  }

  Widget buildCostPerPerson(String title, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xff323643),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          "Rs ${value ?? ""}", // Use empty string if value is null
          style: TextStyle(
            color: Color(0xff323643),
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      ],
    );
  }
}
