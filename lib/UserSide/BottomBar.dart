// ignore_for_file: file_names, library_private_types_in_public_api, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:travel_ease/UserSide/FavoriteScreen.dart';
import 'package:travel_ease/UserSide/Offers.dart';
import 'package:travel_ease/UserSide/Preference.dart';
import 'package:travel_ease/UserSide/ProfileScreen.dart';
import 'package:travel_ease/UserSide/SearchScreen.dart';
import 'package:travel_ease/UserSide/Settings.dart';
import 'package:travel_ease/UserSide/Trips.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String name = 'loading';
  String email = 'email';
  String image = 'Loading...';

  final List<String> pageTitles = [
    'Explore',
    'Trips',
    'Search',
    'Favorites',
    'Profile',
  ];
  void getData() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      var vari = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      var vari1 = await FirebaseFirestore.instance
          .collection('profilepic')
          .doc(user.uid)
          .get();

      if (vari.exists && vari1.exists) {
        setState(() {
          name = vari.data()!['name'] ?? 'No name available';
          email = vari.data()!['email'] ?? 'No email available';
          image = vari1.data()!['profilepic'] ?? 'No image available';
        });
      } else {
        setState(() {
          name = 'Data not found';
          email = 'Data not found';
          image = 'Data not found';
        });
      }
    } else {
      setState(() {
        name = 'User not logged in';
        email = 'User not logged in';
        image = 'User not logged in';
      });
    }
  }

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

  void _contactUs() async {
    final Email email = Email(
      body: 'Hi, I need some help',
      subject: 'Need Help',
      recipients: ['saifrazzaq23@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Error occurred while sending email: $error');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  int selectedpage = 0;
  final _pageNo = [
    HomeScreenUser(),
    TripScreen(),
    SearchScreen(),
    const FavoriteScreen(),
    ProfileScreen()
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: const Color(0xFFC5DDFF),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => scaffoldKey.currentState!.closeDrawer(),
                  icon: Image.asset(
                    "images/back.png",
                    height: 60,
                    width: 60,
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              //DrawerHeader
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  size: 30,
                  color: Color(0xff3277D8),
                ),
                title: const Text(
                  ' My Account ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Get.to(ProfileScreen());
                  scaffoldKey.currentState!.closeDrawer();
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.wallet_outlined,
              //     size: 30,
              //     color: Color(0xff3277D8),
              //   ),
              //   title: const Text(
              //     ' My Wallet',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              //   ),
              // ),

              ListTile(
                leading: const Icon(
                  Icons.travel_explore_outlined,
                  size: 30,
                  color: Color(0xff3277D8),
                ),
                title: const Text(
                  ' My Trips ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Get.to(TripScreen());
                  scaffoldKey.currentState!.closeDrawer();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.percent_outlined,
                  size: 30,
                  color: Color(0xff3277D8),
                ),
                title: const Text(
                  ' Offers ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  // Navigator.pop(context);
                  Get.to(Offers());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings_outlined,
                  size: 30,
                  color: Color(0xff3277D8),
                ),
                title: const Text(
                  ' settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Get.to(UserSettings());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.tune_rounded,
                  size: 30,
                  color: Color(0xff3277D8),
                ),
                title: const Text(
                  ' Preference',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Get.to(Preference());
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.support_agent_outlined,
              //     size: 30,
              //     color: Color(0xff3277D8),
              //   ),
              //   title: const Text(
              //     ' Contact Us ',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              //   ),
              //   onTap: () {
              //     _contactUs();
              //   },
              // ),
              ListTile(
                leading: const Icon(
                  Icons.help_outline,
                  size: 30,
                  color: Color(0xff3277D8),
                ),
                title: const Text(
                  ' Help & support',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  // Define the phone number and message
                  String phoneNumber =
                      '+923249470845'; // Replace with the actual phone number
                  String message =
                      'Hello! I need Help with Travel Ease.'; // Customize your message

                  // Open WhatsApp
                  _openWhatsApp(phoneNumber, message);

                  // final String appLink =
                  //     'https://PakRiders.com/app'; // Replace with the actual app link

                  // Share.share('Check out this amazing app: $appLink');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Color(0xff3277D8),
                ),
                title: const Text(
                  ' LogOut',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroScreen()),
                  );
                  //Get.to(()=>IntroScreen());
                },
              ),
            ],
          ),
        ),
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(60.0),
        //   child: AppBar(
        //     backgroundColor: const Color(0xFFC5DDFF),
        //     title: const Text(
        //       'Explore',
        //       style: TextStyle(color: Color(0xff323643)),
        //     ),
        //   ),
        // ),
        appBar: selectedpage == 1 || selectedpage == 4
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: AppBar(
                  backgroundColor: const Color(0xFFC5DDFF),
                  leading: IconButton(
                    icon: Image.asset(
                      "images/Menu.png",
                      height: 70,
                      width: 70,
                      // height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                    ), // Customize your drawer icon here
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                  title: Text(
                    pageTitles[selectedpage],
                    style: const TextStyle(
                        color: Color(0xff323643), fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true, // Center the title
                ),
              ),

        body: _pageNo[selectedpage],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: const Color(0xffFBA707),
          style: TabStyle.react,
          activeColor: const Color(0xff3277D8), // Set the inactive color

          items: [
            const TabItem(
              activeIcon: Icon(Icons.home_outlined,
                  size: 40,
                  color: Color(0xff3277D8)), // Set the active icon color
              icon: Icon(Icons.home_outlined,
                  color: Color(0xff323643)), // Set inactive icon color to black
            ),
            const TabItem(
              activeIcon: Icon(Icons.travel_explore,
                  size: 40,
                  color: Color(0xff3277D8)), // Set the active icon color
              icon: Icon(Icons.travel_explore, color: Color(0xff323643)),
            ), //

            TabItem(
              icon: Image.asset(
                "images/Search.png",
                fit: BoxFit.fill,
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
              ),
            ),
            const TabItem(
              activeIcon: Icon(Icons.favorite_border_outlined,
                  size: 40,
                  color: Color(0xff3277D8)), // Set the active icon color
              icon: Icon(Icons.favorite_border_outlined,
                  color: Color(0xff323643)), //
            ),
            const TabItem(
              activeIcon: Icon(Icons.person_outline,
                  size: 40,
                  color: Color(0xff3277D8)), // Set the active icon color
              icon: Icon(Icons.person_outline, color: Color(0xff323643)), //
            ),
          ],
          initialActiveIndex: selectedpage,
          onTap: (int index) {
            setState(() {
              selectedpage = index;
            });
          },
        ),
      ),
    );
  }
}
