class ItemType{
  String name;
  String description;

  String? id;
  ItemType(this.name, this.description);

  factory ItemType.fromJSON(Map<String, dynamic> data) => ItemType(data["name"], data["description"]);

  Map<String, dynamic> toMap()=> {
    "name": name,
    "description": description
  };

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}