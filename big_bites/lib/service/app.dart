import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a food item to Firestore collection
  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return await _firestore.collection(name).add(userInfoMap);
  }

  Stream<QuerySnapshot> getFoodItem(String category) {
    return _firestore
        .collection(category.toLowerCase())  // Using the category as the collection
        .snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> cartItem, String userId) async {
    return await _firestore
        .collection('users')
        .doc(userId)
        .collection("cart")
        .add(cartItem);
  }

  Future<void> addToCart(String userId, String itemId, Map<String, dynamic> cartItem) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .set(cartItem);
    } catch (e) {
      print('Error adding to cart: $e');
      throw e;
    }
  }

  Future<void> removeFromCart(String userId, String itemId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .delete();
    } catch (e) {
      print('Error removing from cart: $e');
      throw e;
    }
  }

  Future<void> addToFavourites(String userId, String favId, Map<String, dynamic> favItem) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favoutites')
          .doc(favId)
          .set(favItem);
    } catch (e) {
      print('Error adding to cart: $e');
      throw e;
    }
  }

}
































































































