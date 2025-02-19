import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/kindergarten_module/model/kindergarten_model.dart';
import 'package:kiddocareassessment/src/kindergarten_module/repository/kindergarten_repository.dart';

class KindergartenProvider extends KindergartenRepository {
  KindergartenProvider() {
    setScrollController.addListener(listenScrollController);
  }
  List<KindergartenDataModel> setIndexKindergarten = [];
  List<KindergartenDataModel> get getIndexKindergarten => setIndexKindergarten;

  List<KindergartenDataModel> setFilteredKindergarten = [];
  List<KindergartenDataModel> get getFilteredKindergarten =>
      setFilteredKindergarten;

  bool setHasMore = true;
  bool get getHasMore => setHasMore;

  int setCurrentPage = 1;
  int get getCurrentPage => setCurrentPage;

  Future<void> fetchIndexKindergartenProvider() async {
    print('executed');
    if (setIsLoading || !setHasMore) return;
    setLoadingValue(true);
    try {
      KindergartenModel fetchedKindergartens =
          await fetchIndexKindergartenRepository(page: setCurrentPage);
      if ((setCurrentPage - 1) == fetchedKindergartens.last) {
        setHasMore = false;
      } else {
        setCurrentPage++;
        setIndexKindergarten.addAll(fetchedKindergartens.data ?? []);
        setFilteredKindergarten = [...setIndexKindergarten];
      }
    } catch (error) {
      Exception('Failed to load kindergarten');
    }
    setLoadingValue(false);
  }

  void searchKindergarten(String query) {
    setIsSearchingValue(true);
    // setLoadingValue(true);
    if (query.isEmpty) {
      setFilteredKindergarten = [...setIndexKindergarten];
    } else {
      setFilteredKindergarten = setIndexKindergarten
          .where((item) =>
              (item.name?.toLowerCase().contains(query.toLowerCase()) ??
                  false) ||
              (item.state?.toLowerCase().contains(query.toLowerCase()) ??
                  false))
          .toList();
    }
    // setLoadingValue(false);
    notifyListeners();
  }

  void clearSearchController() {
    setSearchcontroller.clear();
    setFilteredKindergarten = [...setIndexKindergarten];
    setIsSearchingValue(false);
    notifyListeners();
  }

  void getScrollControllerListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setScrollController.addListener(() {
        listenScrollController();
      });
    });
  }

  void listenScrollController() {
    if (setScrollController.position.pixels ==
        setScrollController.position.maxScrollExtent) {
      fetchIndexKindergartenProvider();
    }
  }

  KindergartenDataModel setShowKindergarten = KindergartenDataModel();
  KindergartenDataModel get getShowKindergarten => setShowKindergarten;

  Future<KindergartenDataModel?> fetchShowKindergartenProvider(int id) async {
    setLoadingValue(true);
    try {
      setShowKindergarten = await fetchShowKindergartenRepository(id);
    } catch (error) {
      Exception('Failed to load kindergarten');
    }
    setLoadingValue(false);
    return setShowKindergarten;
  }
}
