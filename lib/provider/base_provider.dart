import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  final Dio dio = Dio();

  ScrollController setScrollController = ScrollController();
  ScrollController get getScrollController => setScrollController;
  TextEditingController setSearchcontroller = TextEditingController();
  TextEditingController get getSearchController => setSearchcontroller;

  bool setIsLoading = false;
  bool get getIsLoading => setIsLoading;

  bool setIsSearching = false;
  bool get getIsSearching => setIsSearching;

  void setLoadingValue(bool value) {
    setIsLoading = value;
    notifyListeners();
  }

  void setIsSearchingValue(bool value) {
    setIsSearching = value;
    notifyListeners();
  }
}
