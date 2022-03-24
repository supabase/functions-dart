enum ResponseType {
  json,
  text,
  arraybuffer,
  blob,
}

class FunctionInvokeOptions {
  Map<String, String>? headers;
  dynamic body;
  ResponseType? responseType;

  FunctionInvokeOptions({
    this.headers,
    this.body,
    this.responseType,
  });
}

class FunctionResponse {
  dynamic data;
  Object? error;

  FunctionResponse({
    this.data,
    this.error,
  });
}
