class Item {
  String title;
  String description;
  String barcode;
  String unit;
  int quantity;
  DateTime createdDate;
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
        "createdDate": createdDate,
        "removedDate": removedDate,
        "isRemoved": isRemoved,
        "authorId": authorId,
      };

  factory Item.fromJSON(Map<String, dynamic> data) => Item(
      data["title"],
      data["description"],
      data["barcode"],
      data["createdDate"].toDate(),
      data["authorId"],
      data["unit"],
      data["quantity"],
      data["removedDate"]
      );
}
