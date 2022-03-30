import 'dart:convert';

import 'package:functions_client/src/types.dart';
import 'package:http/http.dart' as http;

class FunctionsClient {
  final String _url;
  final Map<String, String> _headers;
  FunctionsClient(String url, Map<String, String> headers)
      : _url = url,
        _headers = headers;

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
  /// [invokeOptions] - object with the following properties
  ///
  /// `headers`: object representing the headers to send with the request
  ///
  /// `body`: the body of the request
  ///
  /// `responseType`: how the response should be parsed. The default is `json`
  Future<FunctionResponse> invoke(
    String functionName, [
    FunctionInvokeOptions? invokeOptions,
  ]) async {
    try {
      final headers = invokeOptions?.headers ?? {};
      final body = invokeOptions?.body ?? {};
      final response = await http.post(
        Uri.parse('$_url/$functionName'),
        headers: <String, String>{..._headers, ...headers},
        body: body,
      );

      dynamic data;
      final responseType = invokeOptions?.responseType;
      if (responseType == null || responseType == ResponseType.json) {
        data = json.decode(response.body);
      } else if (responseType == ResponseType.blob) {
        data = response.bodyBytes;
      } else if (responseType == ResponseType.arraybuffer) {
        data = response.bodyBytes;
      } else if (responseType == ResponseType.text) {
        data = response.body;
      } else {
        data = response.body;
      }
      return FunctionResponse(data: data);
    } catch (error) {
      return FunctionResponse(error: error);
    }
  }
}
