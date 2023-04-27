import "package:cloud_firestore/cloud_firestore.dart";
import "package:mobile_app/db/data_models.dart";
import "package:firebase_auth/firebase_auth.dart";

class DBHandler {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _userUID = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser!.uid
      : null;

  Future<bool> addInventory(Inventory inventory) async {
    try {
      final doc = _db.collection("inventories").doc();
      // print(_userUID);
      inventory.userUid = _userUID;
      await doc.set(inventory.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Inventory>> getInventories() async {
    QuerySnapshot documentsSnapshot = await _db.collection("inventories").get();
    final inventories = documentsSnapshot.docs
        .map((json) => Inventory.fromJSON(json.data() as Map<String, dynamic>))
        .toList();
    return inventories;
  }
}
