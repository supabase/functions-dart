import 'package:functions_client/src/functions_client.dart';
import 'package:test/test.dart';

import 'custom_http_client.dart';

void main() {
  late FunctionsClient functionsCustomHttpClient;

  group("Custom http client", () {
    setUp(() {
      functionsCustomHttpClient =
          FunctionsClient("", {}, httpClient: CustomHttpClient());
    });
    test('simple function call', () async {
      final res = await functionsCustomHttpClient.invoke('function');
      expect(res.status, 420);
    });

    test('dispose isolate', () async {
      await functionsCustomHttpClient.dispose();
      expect(functionsCustomHttpClient.invoke('function'), throwsStateError);
    });
  });
}
