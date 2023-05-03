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
        "items": items
      };

  factory Inventory.fromJSON(Map<String, dynamic> data) {
    return Inventory(
        data["title"], data["description"], data["items"], data["owner"]);
  }

  @override
  String toString() {
    return title;
  }
}
