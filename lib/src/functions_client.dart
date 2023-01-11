import 'package:functions_client/src/constants.dart';
import 'package:functions_client/src/types.dart';
import 'package:http/http.dart' as http;
import 'package:yet_another_json_isolate/yet_another_json_isolate.dart';

class FunctionsClient {
  final String _url;
  final Map<String, String> _headers;
  final http.Client? _httpClient;
  final YAJsonIsolate _isolate;
  final bool _hasCustomIsolate;

  /// In case you don't provide your own isolate, call [dispose] when you're done
  FunctionsClient(
    String url,
    Map<String, String> headers, {
    http.Client? httpClient,
    YAJsonIsolate? isolate,
  })  : _url = url,
        _headers = {...Constants.defaultHeaders, ...headers},
        _isolate = isolate ?? (YAJsonIsolate()..initialize()),
        _hasCustomIsolate = isolate != null,
        _httpClient = httpClient;

  /// Updates the authorization header
  ///
  /// [token] - the new jwt token sent in the authorisation header
  void setAuth(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  /// Invokes a function
  ///
  /// [functionName] - the name of the function to invoke
  ///
  /// [headers]: object representing the headers to send with the request
  ///
  /// [body]: the body of the request
  ///
  /// [responseType]: how the response should be parsed. The default is `json`
  Future<FunctionResponse> invoke(
    String functionName, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    ResponseType responseType = ResponseType.json,
  }) async {
    final bodyStr = body == null ? null : await _isolate.encode(body);

    final response = await (_httpClient?.post ?? http.post)(
      Uri.parse('$_url/$functionName'),
      headers: <String, String>{..._headers, if (headers != null) ...headers},
      body: bodyStr,
    );

    final dynamic data;
    if (responseType == ResponseType.json) {
      final resBody = response.body;
      data = resBody.isEmpty ? resBody : await _isolate.decode(resBody);
    } else if (responseType == ResponseType.blob) {
      data = response.bodyBytes;
    } else if (responseType == ResponseType.arraybuffer) {
      data = response.bodyBytes;
    } else if (responseType == ResponseType.text) {
      data = response.body;
    } else {
      data = response.body;
    }
    return FunctionResponse(data: data, status: response.statusCode);
  }

  /// Disposes the self created isolate for json encoding/decoding
  ///
  /// Does nothing if you pass your own isolate
  Future<void> dispose() async {
    if (!_hasCustomIsolate) {
      return _isolate.dispose();
    }
  }
}
