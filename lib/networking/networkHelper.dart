import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  String url;

  Future<String> getdata() async {
    http.Response parser = await http.get(url);
    String data;
    if (parser.statusCode==200) {
      data = parser.body;
      print('Successful');
    } else {
      print(parser.statusCode);
    }
    return data;
  }
}
// API call URL
//https://api.coindesk.com/v1/bpi/currentprice/<CODE>.json