// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:travel_ease/Redux/wishlist_actions.dart';

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String location;
  final String rating;
  final String description;

  CustomCard({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.location,
    required this.rating,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15), // Apply margin
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  imagePath,
                  width: 160,
                  height: 130,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff323643),
                            ),
                          ),
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3277D8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.grey,
                              ),
                              Text(
                                location,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 135, 138, 147),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 70),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rate,
                                color: Colors.green,
                                size: 17,
                              ),
                              Text(
                                rating,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 135, 138, 147),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 135, 138, 147),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  size: 24,
                  color: Colors.red,
                ),
                onPressed: () {
                  // // Dispatch action to add item to wishlist
                  // StoreProvider.of<List<String>>(context)
                  //     .dispatch(AddToWishlistAction(title));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
