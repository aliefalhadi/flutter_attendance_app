import 'package:dio/dio.dart';

Dio createDio({required String baseUrl}) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      contentType: "application/json",
      responseType: ResponseType.json,
    ),
  );
  dio.interceptors.add(logInterceptor());

  return dio;
}

Interceptor logInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    },
    onResponse: (response, handler) {
      // Do something with response data

      return handler.next(response); // continue
    },
    onError: (DioException e, handler) {
      return handler.next(e);
    },
  );
}
