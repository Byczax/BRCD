class Item {
  String title; // Nazwa, cecha etc. (Wymagane do Spisu)
  String description; // opis dłuższy (Wymagane do Spisu)
  String barcode; // Do ogarniania w aplikacji co jest czym
  String unit; // jednostka, szt. litr etc. (Wymagane do Spisu)
  int amount; // ilość (Wymagane do Spisu)
  String createdDate; // Data przydatna w aplikacji
  DateTime? removedDate; // Data przydatna w aplikacji
  bool isRemoved = false; // sprawdzenie czy został usunięty wpis
  String? itemId; // Rozpoznanie w bazie danych
  String authorId; // Na jakim koncie został dodany przedmiot
  int? price; // cena produktu (Wymagane do Spisu)
  Item(this.title, this.description, this.barcode, this.createdDate,
      this.authorId, this.unit, this.amount, this.removedDate, this.price);

  Map<String, dynamic> toMap() => {
        "title": title,
        "barcode": barcode,
        "unit": unit,
        "quantity": amount,
        "description": description,
        "dateCreated": createdDate,
        "removedDate": removedDate,
        "isRemoved": isRemoved,
        "authorId": authorId,
        "price": price
      };

  factory Item.fromJSON(Map<String, dynamic> data) => Item(
      data["title"],
      data["description"],
      data["barcode"],
      data["dateCreated"],
      data["authorId"],
      data["unit"].toString(),
      data["quantity"],
      data["removedDate"],
      1);

  @override
  String toString() {
    // TODO: implement toString
    return title;
  }
}
