import 'package:wallet_manager/core/data/http_client.dart';
import 'package:dio/dio.dart';

class HttpDioImpl implements HttpClientApp {
  Dio dio = Dio();

  HttpDioImpl() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        print('HEADERS: ${options.headers}');
        print('BODY: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print('ERROR[${e.response?.statusCode}] => data: ${e.response?.data}');
        return handler.next(e);
      },
    ));
  }

  @override
  Future<AppHttpResponse> get(String path, {Map<String, String>? headers,}) async {
    var result = await dio.get(path,
        options: Options(
          headers: headers,
        ));
    return AppHttpResponse(
      statusCode: result.statusCode!,
      data: result.data,
    );
  }

  @override
  Future<AppHttpResponse> post(String path, body, {Map<String, String>? headers}) async {
    var result = await dio.post(path,
        data: body,
        options: Options(
          headers: headers,
        ));
    return AppHttpResponse(
      statusCode: result.statusCode!,
      data: result.data,
    );
  }

  @override
  Future<AppHttpResponse> put(String path, body, {Map<String, String>? headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<AppHttpResponse> delete(String path, {Map<String, String>? headers}) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
