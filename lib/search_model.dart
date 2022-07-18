class SearchModel {
  String _searchedText, _region;

  SearchModel(): _searchedText = '', _region = '';

  void setSearchedText({required String text}) {
    _searchedText = text;
  }
  void setRegion({required String region}) {
    _region = region;
  }

  String searchedText() {
    return _searchedText;
  }
  String region() {
    return _region;
  }
}