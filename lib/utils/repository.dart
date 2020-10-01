import 'package:http/http.dart' as http;
import 'package:tsd/models/sscc.dart';
import 'package:tsd/models/ssccModel.dart';

import 'constants.dart';

abstract class Repository {
  /// Throws [NetworkException].
  // Future<void> addSscc(Sscc sscc);
}

class DataRepository {
  Future<SsccModel> addSscc(Sscc sscc) async {
    print('${sscc.toJson()}');
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http.put('${ConfigStorage.baseUrl}dm',
        body: sscc.toJson(), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      return SsccModel.fromJson(response.body);
      // return data;
    } else {
      // print(response.body);
      // response.print('Network connection error');
      throw Exception(response.body);
    }
  }

  Future<SsccModel> getSsccCount(String ssccCode) async {
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http
        .get('${ConfigStorage.baseUrl}sscc/$ssccCode', headers: headers);
    if (response.statusCode == 200) {
      return SsccModel.fromJson(response.body);
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }

  Future<SsccModel> getEanCount(String eanCode) async {
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http
        .get('${ConfigStorage.baseUrl}ean/$eanCode', headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      return SsccModel.fromJson(response.body);
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }

//Очистка таблицы
  Future<void> clearDmTable() async {
    var headers = {"Content-Type": "application/json"};
    final http.Response response =
        await http.delete('${ConfigStorage.baseUrl}dm', headers: headers);
    if (response.statusCode == 200) {
      return null;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }
}

class NetworkException implements Exception {}
