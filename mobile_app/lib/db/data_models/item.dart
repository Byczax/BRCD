import 'package:mobile_app/db/data_models/item_type.dart';

class Item {
  String description;
  DateTime createdDate;
  DateTime? removedDate;
  bool isRemoved = false;
  String authorId;
  String responsibleUser;
  String itemTypeID;
  ItemType? itemType;
  Item(this.description, this.createdDate, this.authorId, this.responsibleUser,
      this.removedDate, this.itemTypeID);

  Map<String, dynamic> toMap()=>{
    "description": description,
    "createdDate": createdDate,
    "removedDate": removedDate,
    "isRemoved": isRemoved,
    "authorId": authorId,
    "responsibleUser": responsibleUser,
    "itemTypeID": itemTypeID
  };


  factory Item.fromJSON(Map<String, dynamic> data) => Item(
      data["description"],
      data["createdDate"].toDate(),
      data["authorId"],
      data["responsibleUser"],
      data["removedDate"],
      data["itemTypeID"]);
// );
}