
import 'package:flutter/foundation.dart';

class SearchModel extends ChangeNotifier {
  String searchBarQuery = "";
  void setSearchQueryTo(String query) {
    searchBarQuery = query.toLowerCase();
    notifyListeners();
  }
}
