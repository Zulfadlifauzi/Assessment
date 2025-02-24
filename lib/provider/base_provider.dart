import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  final Dio dio = Dio();

  late ScrollController setScrollController = ScrollController();
  ScrollController get getScrollController => setScrollController;

  TextEditingController setSearchController = TextEditingController();
  TextEditingController get getSearchController => setSearchController;

  bool setIsLoading = false;
  bool get getIsLoading => setIsLoading;

  void setLoadingValue(bool value) {
    setIsLoading = value;
    notifyListeners();
  }

  String _setErrorMessage = '';
  String get getErrorMessage => _setErrorMessage;

  void setErrorMessage(String message) {
    _setErrorMessage = message;
    notifyListeners();
  }
}
