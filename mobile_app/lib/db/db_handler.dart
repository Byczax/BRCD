import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:mobile_app/db/data_models/inventory.dart";
import "package:mobile_app/db/data_models/item.dart";
import "package:mobile_app/db/data_models/item_type.dart";

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
  // TODO: later it will be good idea to handle it as concrete object instead of dynamic
  Future<dynamic> checkIfBarcodeExists(String barcode) async {
    try {
      final document = await _db.collection(barcodesName).where("barcode", isEqualTo: barcode).get();
      if (document.size != 0) {
        final temp =  await _db.collection(itemName).doc(document.docs.first.get("item")).get();
        final type = await _db.collection(itemTypes).doc(temp.data()!["itemTypeID"]).get();
        final toReturn =  ItemType.fromJSON(type.data()!);
        final cos = Item.fromJSON(temp.data()!);
        cos.itemType = toReturn;
        return cos;
      }
      else{
        return false;
      }
    } catch (e) {
      print(e);
      return false;
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
    final inventories = documentsSnapshot.docs.map((json) {
      var temp = ItemType.fromJSON(json.data() as Map<String, dynamic>);
      temp.id = json.id;
      return temp;
    }
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

  Future<bool> addItem(Map<String, dynamic> data) async{
    final item = Item(data["description"], DateTime.now(), _userUID!, _userUID!, null, data["itemTypeID"]);
    final doc = _db.collection(itemName).doc();
    await doc.set(item.toMap());
    await _db.collection(barcodesName).doc().set({
      "barcode": data["barcode"],
      "item": doc.id
    });
    final list = await _db.collection(inventoryName).doc(data["listID"]).get();
    final asObj = list.get("items") as List<dynamic>;
    asObj.add(item.toMap());
    await _db.collection(inventoryName).doc(data["listID"]).update({"items": asObj});
    // print(asObj);

    return true;
  }

  Future<ItemType?> getItemType(String itemTypeId) async {
    try {
      final doc = await _db.collection(itemTypes).doc(itemTypeId).get();
      return ItemType.fromJSON(doc.data()!);
    }
    catch(e) {
      print("Error at fetching");
      return null;
    }
  }

}
