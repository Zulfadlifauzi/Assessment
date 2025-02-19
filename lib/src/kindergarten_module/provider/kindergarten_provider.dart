import 'package:flutter/material.dart';
import 'package:kiddocareassessment/src/kindergarten_module/model/kindergarten_model.dart';
import 'package:kiddocareassessment/src/kindergarten_module/repository/kindergarten_repository.dart';

class KindergartenProvider extends KindergartenRepository {
  List<KindergartenDataModel> setIndexKindergarten = [];
  List<KindergartenDataModel> get getIndexKindergarten => setIndexKindergarten;

  bool setHasMore = true;
  bool get getHasMore => setHasMore;

  int setCurrentPage = 1;
  int get getCurrentPage => setCurrentPage;

  Future<void> fetchIndexKindergartenProvider() async {
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
      }
    } catch (error) {
      print(error);
    }
    setLoadingValue(false);
  }

  void getScrollControllerListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        listenScrollController();
      });
    });
  }

  void listenScrollController() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
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
      print(error);
    }
    setLoadingValue(false);
    return setShowKindergarten;
  }
}
