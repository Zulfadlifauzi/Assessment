import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/model/kindergarten_model.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/repository/kindergarten_repository.dart';

class KindergartenProvider extends KindergartenRepository {
  KindergartenProvider() {
    fetchIndexKindergartenProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setScrollController.addListener(() {
        listenScrollControllerProvider();
      });
    });
  }

  int setCurrentPage = 1;
  int setPerPage = 10;
  KindergartenDataModel setSelectedState = KindergartenDataModel();

  List<KindergartenDataModel> setFilteredKindergartenList = [];
  List<KindergartenDataModel> get getFilteredKindergartenList =>
      setFilteredKindergartenList;

  bool setHasMore = true;
  bool get getHasMore => setHasMore;

  bool setIsFabVisible = false;
  bool get getIsFabVisible => setIsFabVisible;

  String _setErrorMessage = '';
  String get getErrorMessage => _setErrorMessage;

  List<KindergartenDataModel> setFilteredStates = [
    KindergartenDataModel(
      state: 'Selangor',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Johor',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Perlis',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Kedah',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Perak',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Sabah',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Sarawak',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Pahang',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Negeri Sembilan',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Kelantan',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Terengganu',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Melaka',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Pulau Pinang',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Federal Territory of Putrajaya',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Federal Territory of Kuala Lumpur',
      value: false,
    ),
    KindergartenDataModel(
      state: 'Federal Territory of Labuan',
      value: false,
    ),
  ];
  List<KindergartenDataModel> get getFilteredStates => setFilteredStates;

  Future<void> fetchIndexKindergartenProvider() async {
    if (setIsLoading) return;
    setLoadingValue(true);
    try {
      KindergartenModel fetchedKindergartens =
          await fetchIndexKindergartenRepository(
              page: setCurrentPage, perPage: setPerPage);

      List<KindergartenDataModel> newKindergartenData =
          fetchedKindergartens.data ?? [];

      setCurrentPage++;

      int nextPage = fetchedKindergartens.next ?? 0;
      if (nextPage == 0) {
        setHasMore = false;
      }
      setFilteredKindergartenList.addAll(newKindergartenData);
    } catch (error) {
      setErrorMessage(error.toString());
    } finally {
      setLoadingValue(false);
      notifyListeners();
    }
  }

  Future<void> fetchIndexsearchKindergartenProvider() async {
    if (setIsLoading || !setHasMore) return;
    setLoadingValue(true);
    try {
      KindergartenModel fetchedKindergartens =
          await fetchIndexKindergartenRepository(page: setCurrentPage);

      List<KindergartenDataModel> newData = fetchedKindergartens.data ?? [];

      setCurrentPage++;

      final String searchQuery = setSearchController.text.toLowerCase();

      if (setSelectedState.state != null) {
        newData = newData
            .where((item) =>
                item.state.toString().toLowerCase().contains(
                    setSelectedState.state.toString().toLowerCase()) &&
                item.name.toString().toLowerCase().contains(searchQuery))
            .toList();
      } else {
        newData = newData
            .where((item) =>
                item.state.toString().toLowerCase().contains(searchQuery) ||
                item.name.toString().toLowerCase().contains(searchQuery))
            .toList();
      }
      setFilteredKindergartenList.addAll(newData);

      if (fetchedKindergartens.next == null) {
        setHasMore = false;
      } else {
        await fetchIndexsearchKindergartenProvider();
      }
    } catch (error) {
      setErrorMessage(error.toString());
    } finally {
      setLoadingValue(false);
      notifyListeners();
    }
  }

  Future<void> searchKindergartenProvider(String query) async {
    setSearchController.text = query;
    cleanUpListProvider();
    await fetchIndexsearchKindergartenProvider();
    notifyListeners();
  }

  Future<void> refreshKindergartenListProvider() async {
    cleanUpListProvider();
    if (setSelectedState.state != '' && setSelectedState.state != null) {
      await fetchIndexsearchKindergartenProvider();
    } else {
      await fetchIndexKindergartenProvider();
    }
    notifyListeners();
  }

  Future<void> clearSearchControllerProvider() async {
    setSearchController.clear();
    cleanUpListProvider();
    if (setSelectedState.state != '' && setSelectedState.state != null) {
      await fetchIndexsearchKindergartenProvider();
    } else {
      await fetchIndexKindergartenProvider();
    }
    notifyListeners();
  }

  Future<void> setFilteredByStateProvider({String? selectedStateByUser}) async {
    if (selectedStateByUser.toString().isNotEmpty) {
      for (var element in setFilteredStates) {
        element.value = element.state == selectedStateByUser;
      }
      cleanUpListProvider();
      await fetchIndexsearchKindergartenProvider();
    } else {
      for (var element in setFilteredStates) {
        element.value = false;
      }
      setSelectedState.state = '';
    }
    notifyListeners();
  }

  void toggleStateSelectionsProvider(int index) async {
    bool isSelected = setFilteredStates[index].value ?? false;
    setFilteredStates[index].value = !isSelected;
    notifyListeners();

    setSearchController.clear();
    cleanUpListProvider();

    if (isSelected) {
      await fetchIndexKindergartenProvider();
      await setFilteredByStateProvider(selectedStateByUser: '');
    } else {
      setSelectedState.state = setFilteredStates[index].state;
      await setFilteredByStateProvider(
          selectedStateByUser: setFilteredStates[index].state.toString());
    }
  }

  void listenScrollControllerProvider() {
    if (setScrollController.position.pixels > 0) {
      if (!setIsFabVisible) {
        setIsFabVisible = true;
        notifyListeners();
      }
    } else {
      if (setIsFabVisible) {
        setIsFabVisible = false;
        notifyListeners();
      }
    }

    if (setScrollController.position.pixels ==
            setScrollController.position.maxScrollExtent &&
        getHasMore) {
      fetchIndexKindergartenProvider();
    }
  }

  void cleanUpListProvider() {
    setFilteredKindergartenList = [];
    setCurrentPage = 1;
    setHasMore = true;
    notifyListeners();
  }

  @override
  void dispose() {
    setScrollController.removeListener(listenScrollControllerProvider);
    setScrollController.dispose();
    setSearchController.dispose();
    super.dispose();
  }

  KindergartenDataModel setShowKindergarten = KindergartenDataModel();
  KindergartenDataModel get getShowKindergarten => setShowKindergarten;

  Future<KindergartenDataModel?> fetchShowKindergartenProvider(int id) async {
    setLoadingValue(true);
    try {
      setShowKindergarten = await fetchShowKindergartenRepository(id);
    } catch (error) {
      setErrorMessage(error.toString());
    } finally {
      setLoadingValue(false);
    }
    return setShowKindergarten;
  }

  void setErrorMessage(String message) {
    _setErrorMessage = message;
    notifyListeners();
  }
}
