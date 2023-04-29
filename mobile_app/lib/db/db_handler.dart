import "package:cloud_firestore/cloud_firestore.dart";
import "package:mobile_app/db/data_models.dart";
import "package:firebase_auth/firebase_auth.dart";

class DBHandler {
  final String inventoryName = "inventories";
  final String barcodesName = "barcodes";
  final String itemName = "items";
  final String itemTypes = "item-types";
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

  Future<Item?> checkIfBarcodeExists(String barcode) async {
    try {
      final document = await _db.collection(barcodesName).doc(barcode).get();
      if (document.exists) {
        final temp =  await _db.collection(itemName).doc(document["itemID"]).get();
        return Item.fromJSON(temp.data()!);
      };
    } catch (e) {
      print("error");
      return null;
    }
  }

  Future<bool> addBarcode(String barcode, String itemID)async {
    try{
    final collection = _db.collection(barcodesName);
    await collection.doc(barcode).set({"itemID": itemID});
    return true;
    } catch (e) {
      print("error");
      return false;
    }
  }

  Future<List<ItemType>>getItemTypes() async{
    QuerySnapshot documentsSnapshot = await _db.collection(itemTypes).get();
    final inventories = documentsSnapshot.docs.map((json)
      =>ItemType.fromJSON(json.data() as Map<String, dynamic>)
    ).toList();
    return inventories;
  }

  Future<bool> addItemType(ItemType itemType) async {
    try {
      final doc = _db.collection(itemTypes).doc();
      await doc.set(itemType.toMap());
      return true;
    } catch (e) {
      print("Cos nie poszło");
      return false;
    }
  }
}
