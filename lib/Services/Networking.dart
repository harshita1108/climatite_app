import 'package:http/http.dart'
    as http; // now place where we use http we will know that everything there came from this package
import 'dart:convert'; // used while using jason

class NetworkHelper {
  NetworkHelper(this.url); // constructor

  final String url;

  Future getData() async {
    http.Response response = await http.get(url); //Response is datatype
    if (response.statusCode == 200) {
      // here 200 status code means everthing went well while interacting with server
      String data = response
          .body; // while interacting with server statusCode helps in giving status like we get 404(a status code) from a server this indicates us something got wrong

      var Decodeddata = jsonDecode(
          data); // giving var which is dynamic datatype as output will be dynamic
      // also if want to specify datatype instead of using var go see the type of data in jsonDecode(data) and use datatype accordingly.
      return Decodeddata;
    } else {
      print(response.statusCode);
    }
  }
}
