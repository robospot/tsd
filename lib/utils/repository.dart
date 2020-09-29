import 'package:http/http.dart' as http;
import 'package:tsd/models/sscc.dart';

import 'constants.dart';

abstract class Repository {
  /// Throws [NetworkException].
  // Future<void> addSscc(Sscc sscc);
}

class DataRepository {
  Future<String> addSscc(Sscc sscc) async {
    print('${sscc.toJson()}');
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http.put('${ConfigStorage.baseUrl}dm',
        body: sscc.toJson(), headers: headers);
    if (response.statusCode == 200) {
      // Sscc data = Company.fromJson(json.decode(response.body));
      return response.body;
      // return data;
    } else {
      // print(response.body);
      // response.print('Network connection error');
       throw Exception(response.body);
    }
  }

  Future<String> getSsccCount(String ssccCode) async {
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http
        .get('${ConfigStorage.baseUrl}sscc/$ssccCode', headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }
}

class NetworkException implements Exception {}
