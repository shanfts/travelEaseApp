import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:travel_ease/Redux/wishlist_actions.dart';
import 'package:travel_ease/UserSide/TourDetail.dart';
import 'package:travel_ease/Utils/ScreenSizes.dart';

import '../constants.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var text;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  List<Map<String, dynamic>> toursData = [];
  List<Map<String, dynamic>> filteredToursData = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    fetchToursData();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      print("Search field is focused");
      // Add any specific logic here when the search field gains focus
    } else {
      print("Search field lost focus");
      // Add any specific logic here when the search field loses focus
    }
  }

  void fetchToursData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('tours').get();
      List<Map<String, dynamic>> tours = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> tourData = doc.data() as Map<String, dynamic>;
        tours.add(tourData);
      });
      setState(() {
        toursData = tours;
        filteredToursData = tours; // Initially, all data is shown
      });
    } catch (error) {
      print("Error fetching tours data: $error");
    }
  }

  void filterToursData(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredToursData = toursData;
      });
      return;
    }

    List<Map<String, dynamic>> filteredTours = [];
    for (var tour in toursData) {
      bool matchesQuery = false;
      // Check if placeName contains query
      if (tour["placeName"]
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchesQuery = true;
      }
      // Check if costPerPerson is less than or equal to query amount
      try {
        double enteredCost = double.parse(query);
        double tourCost = double.parse(tour["costPerPerson"]);
        if (tourCost <= enteredCost) {
          matchesQuery = true;
        }
      } catch (e) {
        print("Error parsing cost: $e");
      }

      if (matchesQuery) {
        filteredTours.add(tour);
      }
    }

    setState(() {
      filteredToursData = filteredTours;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFC5DDFF),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5 * SizeConfig.heightRef,
                ),
                Container(
                  height: 60.0 * SizeConfig.heightRef,
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, -4), // Move shadow up
                        blurRadius: 5,
                        spreadRadius:
                            2, // Spread radius is negative for inner shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xff606470),
                        size: 30 * SizeConfig.fontRef,
                      ),
                      SizedBox(
                        width: 10.0 * SizeConfig.heightRef,
                      ),
                      Expanded(
                        child: TextFormField(
                          key: ValueKey('Search'),
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: Color(0xff606470),
                            ),
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (value) {
                            print("Search query submitted: $value");
                            filterToursData(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30 * SizeConfig.heightRef,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  shrinkWrap: true, // Wrap content
                  itemCount: filteredToursData.length,
                  itemBuilder: (context, index) {
                    final data = filteredToursData[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(TourDetailScreen(data: data));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: 15 * SizeConfig.heightRef), // Apply margin
                        height: 150 * SizeConfig.heightRef,
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
                                SizedBox(width: 5 * SizeConfig.widthRef),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    data["imageURL"], // Change to imageURL
                                    width: 160 * SizeConfig.widthRef,
                                    height: 130 * SizeConfig.heightRef,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: 8 * SizeConfig.heightRef),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data["title"],
                                              style: TextStyle(
                                                fontSize:
                                                    16 * SizeConfig.fontRef,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xff323643),
                                              ),
                                            ),
                                            Text(
                                              "Rs ${data["costPerPerson"]}",
                                              style: TextStyle(
                                                fontSize:
                                                    14 * SizeConfig.fontRef,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff3277D8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: 5 * SizeConfig.heightRef),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  data["placeName"],
                                                  style: TextStyle(
                                                    fontSize:
                                                        14 * SizeConfig.fontRef,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromARGB(
                                                        255, 135, 138, 147),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                width:
                                                    20 * SizeConfig.widthRef),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star_rate,
                                                  color: Colors.green,
                                                  size: 17 * SizeConfig.fontRef,
                                                ),
                                                Text(
                                                  "4.5",
                                                  style: TextStyle(
                                                    fontSize:
                                                        14 * SizeConfig.fontRef,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromARGB(
                                                        255, 135, 138, 147),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          data["description"],
                                          style: TextStyle(
                                            fontSize: 14 * SizeConfig.fontRef,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 135, 138, 147),
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
                                height: 35 * SizeConfig.heightRef,
                                width: 35 * SizeConfig.widthRef,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  icon: StoreConnector<
                                      List<Map<String, dynamic>>, bool>(
                                    converter: (store) {
                                      // Check if the item exists in the wishlist
                                      return store.state.any((item) =>
                                          item["title"] == data["title"]);
                                    },
                                    builder: (context, isInWishlist) {
                                      return Icon(
                                        isInWishlist
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 22 * SizeConfig.fontRef,
                                        color: isInWishlist
                                            ? Colors.red
                                            : Colors.red,
                                      );
                                    },
                                  ),
                                  onPressed: () async {
                                    final isInWishlist = StoreProvider.of<
                                            List<Map<String, dynamic>>>(context)
                                        .state
                                        .any((item) =>
                                            item["title"] == data["title"]);

                                    if (isInWishlist) {
                                      // Remove the item from the wishlist
                                      StoreProvider.of<
                                                  List<Map<String, dynamic>>>(
                                              context)
                                          .dispatch(
                                              RemoveFromWishlistAction(data));
                                      Utils().toastMessage(
                                        message: 'Item removed from wishlist',
                                        backgroundColor: Colors.green,
                                      );
                                    } else {
                                      // Add the item to the wishlist
                                      StoreProvider.of<
                                                  List<Map<String, dynamic>>>(
                                              context)
                                          .dispatch(AddToWishlistAction(data));
                                      Utils().toastMessage(
                                        message: 'Item added to wishlist',
                                        backgroundColor: Colors.green,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 60 * SizeConfig.heightRef,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
