enum ResponseType {
  json,
  text,
  arraybuffer,
  blob,
}

class FunctionInvokeOptions {
  Map<String, dynamic>? headers;
  dynamic body;
  ResponseType? responseType;

  FunctionInvokeOptions({
    this.headers,
    this.body,
    this.responseType,
  });
}
