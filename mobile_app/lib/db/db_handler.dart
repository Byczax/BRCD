import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:mobile_app/db/data_models/inventory.dart";
import "package:mobile_app/db/data_models/item.dart";

class DBHandler {
  final String inventoryName = "inventories";
  final String itemName = "items";
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _userUID = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser!.uid
      : null;

  Future<bool> addInventory(Inventory inventory) async {
    try {
      final doc = _db.collection(inventoryName).doc();
      inventory.userUid = _userUID;
      await doc.set(inventory.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Inventory>> getInventories() async {
    QuerySnapshot documentsSnapshot = await _db.collection(inventoryName).get();
    final inventories = documentsSnapshot.docs.map((json) {
      print(json.data());
      final inventory = Inventory.fromJSON(json.data() as Map<String, dynamic>);
      inventory.id = json.id;
      return inventory;
    }).where((element) {
      return element.userUid == _userUID;
    }).toList();
    return inventories;
  }

  Future<bool> removeInventory(String documentId) async {
    try {
      await _db.collection(inventoryName).doc(documentId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  // TODO: later it will be good idea to handle it as concrete object instead of dynamic
  Future<dynamic> checkIfBarcodeExists(String barcode) async {
    try {
      final document = await _db
          .collection(itemName)
          .where("barcode", isEqualTo: barcode)
          .get();
      if (document.size != 0) {
        // final temp = await _db
        //     .collection(itemName)
        //     .doc(document.docs.first.get("item"))
        //     .get();
        print(document.docs[0].data());
        final cos = Item.fromJSON(document.docs[0].data());
        print("cos ${cos.title}");
        return cos;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Item>> getItems() async {
    QuerySnapshot documentsSnapshot = await _db.collection(itemName).get();
    final inventories = documentsSnapshot.docs.map((json) {
      var temp = Item.fromJSON(json.data() as Map<String, dynamic>);
      temp.itemId = json.id;
      return temp;
    }).where((element) => element.authorId == _userUID).toList();
    return inventories;
  }

  Future<bool> addItem(Map<String, dynamic> data) async {
    final doc = _db.collection(itemName).doc();
    data["authorId"] = _userUID!;
    await doc.set(data);

    return true;
  }

  Future<bool> addToInventory(Map<String, dynamic> data) async {
    final list = await _db.collection(inventoryName).doc(data["listID"]).get();
    final id = data.remove("listID");
    final asObj = list.get("items") as List<dynamic>;
    asObj.add(data);
    await _db.collection(inventoryName).doc(id).update({"items": asObj});
    return true;
  }

  Future<bool> removeItem(String documentId) async {
    await _db.collection(itemName).doc(documentId).delete();
    return true;
  }

  Future<bool> removeFromInventory(Item item, Inventory inventory) async {
    final list = await _db.collection(inventoryName).doc(inventory.documentId).get();
    final items = list.get("items") as List<dynamic>;
    final filtered =items.where((e) => e["barcode"] != item.barcode).toList();
    await _db.collection(inventoryName).doc(inventory.documentId).update({"items": filtered});
    return true;
  }
}
