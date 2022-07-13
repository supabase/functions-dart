enum ResponseType {
  json,
  text,
  arraybuffer,
  blob,
}

class FunctionInvokeOptions {
  final Map<String, String>? headers;
  final dynamic body;
  final ResponseType? responseType;

  FunctionInvokeOptions({
    this.headers,
    this.body,
    this.responseType,
  });
}

class FunctionResponse {
  final dynamic data;
  final Object? error;
  final int? status;

  FunctionResponse({
    this.data,
    this.error,
    this.status,
  });
}
