import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  final Dio dio = Dio();

  ScrollController setScrollController = ScrollController();
  ScrollController get getScrollController => setScrollController;

  bool setIsLoading = false;
  bool get getIsLoading => setIsLoading;

  void setLoadingValue(bool value) {
    setIsLoading = value;
    notifyListeners();
  }
}
