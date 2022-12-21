import 'package:http/http.dart' as http;

class ServiceCall{
  static Future<http.Response> get(String url) async {
    print('URL> $url');
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
// AppConstants.printLog('Response> ${response.body.toString()}');
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load API');
    }
  }
}