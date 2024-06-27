import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'wishlist_actions.dart';
import 'wishlist_reducer.dart';

// Define the store with the reducer and initial state
final Store<List<Map<String, dynamic>>> store =
    Store<List<Map<String, dynamic>>>(
  wishlistReducer,
  initialState: [], // Initial state
);

class StoreProviderWidget extends StatelessWidget {
  final Widget child;

  const StoreProviderWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<List<Map<String, dynamic>>>(
      store: store,
      child: child,
    );
  }
}

// Check if an item is added to the wishlist
void checkItemAdded(BuildContext context) {
  final List<Map<String, dynamic>> previousState = store.state;

  // Dispatch an action to add an item to the wishlist (for testing)
  store.dispatch(AddToWishlistAction({
    "id": 1,
    "name": "Item 1",
    // Add other item properties here
  }));

  final List<Map<String, dynamic>> currentState = store.state;

  if (currentState.length > previousState.length) {
    // Item has been added to the wishlist
    print("Item has been added to the wishlist");
  } else {
    print("Item has not been added to the wishlist");
  }
}

// Get all items from the wishlist
List<Map<String, dynamic>> getAllItemsFromWishlist(BuildContext context) {
  return StoreProvider.of<List<Map<String, dynamic>>>(context).state;
}
