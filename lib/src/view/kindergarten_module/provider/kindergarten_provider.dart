import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/model/kindergarten_model.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/repository/kindergarten_repository.dart';

class KindergartenProvider extends KindergartenRepository {
  KindergartenProvider() {
    fetchIndexKindergartenProvider();
    getScrollControllerListener();
  }

  List<KindergartenDataModel> setFilteredKindergarten = [];
  List<KindergartenDataModel> get getFilteredKindergarten =>
      setFilteredKindergarten;

  bool setHasMore = true;
  bool get getHasMore => setHasMore;

  int setCurrentPage = 1;
  int get getCurrentPage => setCurrentPage;

  String setCurrentSearchQuery = "";
  String get getCurrentSearchQuery => setCurrentSearchQuery;

  int setPerPage = 10;
  int get getPerPage => setPerPage;

  TextEditingController setSearchcontroller = TextEditingController();
  TextEditingController get getSearchController => setSearchcontroller;

  Future<void> fetchIndexKindergartenProvider() async {
    if (setIsLoading || !setHasMore) return;
    setLoadingValue(true);
    try {
      KindergartenModel fetchedKindergartens =
          await fetchIndexKindergartenRepository(
              page: setCurrentPage, perPage: setPerPage);

      final bool isLastPage =
          (fetchedKindergartens.data?.length ?? 0) <= setCurrentPage;

      setCurrentPage++;
      if (isLastPage) {
        setHasMore = false;
      }
      setFilteredKindergarten.addAll(fetchedKindergartens.data ?? []);
    } catch (error) {
      print('Error: Failed to load kindergarten: $error');
    } finally {
      setLoadingValue(false);
      notifyListeners();
    }
  }

  Future<void> fetchSearchKindergartens() async {
    if (setIsLoading || !setHasMore) return;
    setLoadingValue(true);
    try {
      KindergartenModel fetchedKindergartens =
          await fetchIndexKindergartenRepository(page: setCurrentPage);

      List<KindergartenDataModel> newData = fetchedKindergartens.data ?? [];

      setCurrentPage++;

      newData = newData
          .where((item) =>
              (item.name
                      ?.toLowerCase()
                      .contains(setCurrentSearchQuery.toLowerCase()) ??
                  false) ||
              (item.state
                      ?.toLowerCase()
                      .contains(setCurrentSearchQuery.toLowerCase()) ??
                  false))
          .toList();
      setFilteredKindergarten.addAll(newData);

      if ((setCurrentPage - 1) == fetchedKindergartens.last) {
        setHasMore = false;
      } else {
        await fetchSearchKindergartens();
      }
    } catch (error) {
      print('Error fetching search results: $error');
    } finally {
      setLoadingValue(false);
      notifyListeners();
    }
  }

  Future<void> searchKindergarten(String query) async {
    setCurrentSearchQuery = query;
    setCurrentPage = 1;
    setHasMore = true;
    setFilteredKindergarten = [];
    if (query.isEmpty) {
      await fetchIndexKindergartenProvider();
      notifyListeners();
      return;
    }
    await fetchSearchKindergartens();
  }

  Future<void> refreshKindergarten() async {
    setCurrentSearchQuery = "";
    setSearchcontroller.clear();
    setCurrentPage = 1;
    setHasMore = true;
    setFilteredKindergarten = [];
    await fetchIndexKindergartenProvider();
    notifyListeners();
  }

  void clearSearchController() {
    setSearchcontroller.clear();
    setFilteredKindergarten = [];
    setCurrentPage = 1;
    setHasMore = true;
    fetchIndexKindergartenProvider();
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
      // if (setIsSearching && setHasMore) {
      //   // fetchSearchKindergartens();
      // } else if (!setIsSearching && setHasMore) {
      //   fetchIndexKindergartenProvider();
      // }
    }
  }

  @override
  void dispose() {
    setScrollController.removeListener(listenScrollController);
    setScrollController.dispose();
    setSearchcontroller.dispose();
    super.dispose();
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
