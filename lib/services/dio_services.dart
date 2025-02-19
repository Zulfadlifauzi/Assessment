import 'package:dio/dio.dart';

import '../provider/base_provider.dart';

class DioServices extends BaseProvider {
  DioServices() {
    Dio(
      BaseOptions(
        sendTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60), // 60 seconds
        receiveTimeout: const Duration(seconds: 60), // 60 seconds
        validateStatus: (status) => status! < 600,
      ),
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        setLoadingValue(true);
        handler.next(options);
      },
      onResponse: (response, handler) async {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          handler.next(response);
        }
        setLoadingValue(false);
      },
      onError: (error, handler) async {
        handler.resolve(
            error.response ?? Response(requestOptions: error.requestOptions));
        setLoadingValue(false);
      },
    ));
  }
}
