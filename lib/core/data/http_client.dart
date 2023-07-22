class AppHttpResponse {
  int statusCode;
  Map<String, String>? headers;
  dynamic data;

  AppHttpResponse({
    required this.statusCode,
    this.headers,
    required this.data,
  });
}

abstract class HttpClientApp {
  Future<AppHttpResponse> get(String path, {Map<String, String>? headers});

  Future<AppHttpResponse> post(String path, dynamic body, {Map<String, String>? headers});

  Future<AppHttpResponse> put(String path, dynamic body, {Map<String, String>? headers});

  Future<AppHttpResponse> delete(String path, {Map<String, String>? headers});
}
