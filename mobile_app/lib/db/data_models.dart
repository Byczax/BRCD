class Inventory {
  final String title;
  final String description;
  String? _userUid;

  set userUid(String? value) {
    _userUid = value;
  }

  final dynamic items;
  Inventory(this.title, this.description, this.items, [_userUid]);

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "owner": _userUid,
        "items": []
      };

  factory Inventory.fromJSON(Map<String, dynamic> data) => Inventory(
      data["title"], data["description"], data["items"], data["owner"]);
}
