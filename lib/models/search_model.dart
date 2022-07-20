import 'package:league_tracker/views/region_button.dart';

class SearchModel {
  String _searchedText;
  LolServers _server;

  SearchModel(): _searchedText = '', _server = LolServers.euw1;

  void setSearchedText({required String text}) {
    _searchedText = text;
  }
  void setServer({required LolServers server}) {
    _server = server;
  }

  String searchedText() {
    return _searchedText;
  }

  LolServers server() {
    return _server;
  }
}