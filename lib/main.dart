import 'dart:convert';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_storage/get_storage.dart';
import 'package:redux/redux.dart';
import 'package:travel_ease/AdminSide/AdminHome.dart';
import 'package:travel_ease/UserSide/BottomBar.dart';
import 'package:travel_ease/Utils/ScreenSizes.dart';
import 'package:travel_ease/firebase_options.dart';

import './Redux/wishlist_reducer.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Retrieve the initial state from local storage
  List<Map<String, dynamic>> initialState = await _getInitialWishlistState();
  await GetStorage.init();
  runApp(MyApp(initialState: initialState));
}

Future<List<Map<String, dynamic>>> _getInitialWishlistState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? wishlistJson = prefs.getString('wishlist');
  if (wishlistJson != null) {
    return json.decode(wishlistJson).cast<Map<String, dynamic>>();
  } else {
    return [];
  }
}

class MyApp extends StatelessWidget {
  final List<Map<String, dynamic>> initialState;

  const MyApp({super.key, required this.initialState});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return StoreProvider<List<Map<String, dynamic>>>(
      store: Store<List<Map<String, dynamic>>>(
        wishlistReducer,
        initialState: initialState,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loader while checking auth state
            } else if (snapshot.hasData) {
              // User is logged in
              final currentUser = snapshot.data!;
              if (currentUser.email == 'admin.te@gmail.com') {
                return AdminScreen(); // Navigate to admin screen
              } else {
                return const MyHomePage(); // Navigate to user home page
              }
            } else {
              return const SplashScreen(); // User is not logged in
            }
          },
        ),
      ),
    );
  }
}
