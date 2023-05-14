class Item {
  String title;
  String description;
  String barcode;
  String unit;
  int quantity;
  String createdDate;
  DateTime? removedDate;
  bool isRemoved = false;
  String authorId;
  Item(this.title, this.description, this.barcode, this.createdDate, this.authorId,
      this.unit, this.quantity,
      this.removedDate);

  Map<String, dynamic> toMap() => {
        "title": title,
        "barcode": barcode,
        "unit": unit,
        "quantity": quantity,
        "description": description,
        "dateCreated": createdDate,
        "removedDate": removedDate,
        "isRemoved": isRemoved,
        "authorId": authorId,
      };

  factory Item.fromJSON(Map<String, dynamic> data) => Item(
      data["title"],
      data["description"],
      data["barcode"],
      data["dateCreated"],
      data["authorId"],
      data["unit"].toString(),
      data["quantity"],
      data["removedDate"]
      );
}
