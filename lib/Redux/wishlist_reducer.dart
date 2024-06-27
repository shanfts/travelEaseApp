import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'wishlist_actions.dart';

List<Map<String, dynamic>> wishlistReducer(
    List<Map<String, dynamic>> state, dynamic action) {
  if (action is AddToWishlistAction) {
    List<Map<String, dynamic>> newState = List.from(state)
      ..add(action.itemData);
    _saveWishlistToLocalStorage(newState);
    return newState;
  } else if (action is RemoveFromWishlistAction) {
    List<Map<String, dynamic>> newState = List.from(state);
    newState.removeWhere((item) => item["id"] == action.itemData["id"]);
    _saveWishlistToLocalStorage(newState);
    return newState;
  }
  return state;
}

void _saveWishlistToLocalStorage(List<Map<String, dynamic>> wishlist) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('wishlist', json.encode(wishlist));
  print("Wishlist updated: ${json.encode(wishlist)}"); // Debugging line
}
