import '../constants.dart';

class FirestoreServices {
  static saveUser(String name, email, password, address, uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'name': name,
      'pasword': password,
      'address': address
    });
  }
}
