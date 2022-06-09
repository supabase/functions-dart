import 'package:functions_client/src/functions_client.dart';
import 'package:test/test.dart';

import 'custom_http_client.dart';

void main() {
  late FunctionsClient functionsCustomHttpClient;
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(1 + 1, 2);
    });
  });

  group("Custom http client", () {
    setUpAll(() {
      functionsCustomHttpClient =
          FunctionsClient("", {}, httpClient: CustomHttpClient());
    });
    test('simple function call', () async {
      final res = await functionsCustomHttpClient.invoke('function');
      expect(res.status, 420);
    });
  });
}
