import 'package:http/http.dart' as http;
import 'package:tsd/models/sscc.dart';

import 'constants.dart';

abstract class Repository {
  /// Throws [NetworkException].
  Future<void> addSscc(Sscc sscc);
}

class DataRepository implements Repository {
  @override
  Future<void> addSscc(Sscc sscc) async {
    print('${sscc.toJson()}');
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http.put(
        '${ConfigStorage.baseUrl}dm',
        body: sscc.toJson(),
        headers: headers);
    if (response.statusCode == 200) {
      // Sscc data = Company.fromJson(json.decode(response.body));

      // return data;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }

  Future<String> getSsccCount(String ssccCode) async {
    print('request');
    print(ssccCode);
    
        var headers = {"Content-Type": "application/json"};
    final http.Response response = await http
        .get('${ConfigStorage.baseUrl}sscc/$ssccCode',  headers: headers);
    if (response.statusCode == 200) {
      // Sscc data = Company.fromJson(json.decode(response.body));
      print(response.body);
      return response.body;
      // return data;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }
}

class NetworkException implements Exception {}
