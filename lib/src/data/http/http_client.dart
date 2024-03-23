import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future get({required String url});
}

class HttpClientImpl implements HttpClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

}