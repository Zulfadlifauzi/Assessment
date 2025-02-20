import 'package:dio/dio.dart';
import 'package:kiddocareassessment/services/dio_services.dart';
import 'package:kiddocareassessment/src/view/kindergarten_module/model/kindergarten_model.dart';

import '../../../../constants/api_constants.dart';

class KindergartenRepository extends DioServices {
  Future<KindergartenModel> fetchIndexKindergartenRepository(
      {int? page, int? perPage}) async {
    try {
      final Response response = await dio.get(
        baseUrl,
        queryParameters: {
          '_page': page,
          'per_page': perPage,
        },
      );
      if (response.statusCode == 200) {
        return KindergartenModel.fromJson(
          response.data,
        );
      } else {
        throw Exception('Failed to load kindergarten');
      }
    } catch (e) {
      throw Exception('Failed to load kindergarten');
    }
  }

  Future<KindergartenDataModel> fetchShowKindergartenRepository(int id) async {
    try {
      final response = await dio.get('$baseUrl$id');
      if (response.statusCode == 200) {
        return KindergartenDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load kindergarten');
      }
    } catch (e) {
      throw Exception('Failed to load kindergarten');
    }
  }
}
