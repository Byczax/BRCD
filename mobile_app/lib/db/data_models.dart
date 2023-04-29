class Inventory {
  final String title;
  final String description;
  String? userUid;
  String? _inventoryId;

  set id(String id) {
    _inventoryId = id;
  }

  get documentId => _inventoryId;

  final List<dynamic> items;
  Inventory(this.title, this.description, this.items, this.userUid);

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "owner": userUid,
        "items": []
      };

  factory Inventory.fromJSON(Map<String, dynamic> data) {
    return Inventory(
        data["title"], data["description"], data["items"], data["owner"]);
  }
}

class Item {
  String description;
  DateTime createdDate;
  DateTime? removedDate;
  bool isRemoved = false;
  String authorId;
  String responsibleUser;
  Item(this.description, this.createdDate, this.authorId, this.responsibleUser,
      this.removedDate);

  Map<String, dynamic> toMap()=>{
     "description": description,
    "createdDate": createdDate,
    "removedDate": removedDate,
    "isRemoved": isRemoved,
    "authorId": authorId,
    "responsibleUser": responsibleUser
  };


  factory Item.fromJSON(Map<String, dynamic> data) => Item(
      data["description"],
      data["createdDate"],
      data["authorId"],
      data["responsibleUser"],
      data["removedDate"]);
}
// TODO: Think about sticking with ERD 1:1 or to change structure to have barcode as a field instead of as documentID
// class Barcode{
//   String itemID;
//   Barcode(this.itemID);
//
//   factory Barcode.fromJSON(Map<String, dynamic> data) => Barcode(
//     data["itemID"],
//   );
//   Map<String, dynamic> toMap()=>{
//     "itemID": itemID
//   };
// }
class ItemType{
  String name;
  String description;
  ItemType(this.name, this.description);

  factory ItemType.fromJSON(Map<String, dynamic> data) => ItemType(data["name"], data["description"]);

  Map<String, dynamic> toMap()=> {
    "name": name,
    "description": description
  };
}