import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:tsd/models/packList.dart';
import 'package:tsd/models/sscc.dart';
import 'package:tsd/models/ssccModel.dart';

import 'authentication/auth_dio.dart';
import 'constants.dart';

abstract class Repository {
  /// Throws [NetworkException].
  // Future<void> addSscc(Sscc sscc);
}

class DataRepository {
  var oauth = OAuth(
      clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');
  var request = Dio();

  Future<SsccModel> addSscc(Sscc sscc) async {
    print('${sscc.toJson()}');
    request.interceptors.add(BearerInterceptor(oauth));
    var response =
        await request.put('${ConfigStorage.baseUrl}dm', data: sscc.toJson());
    print('response: $response');

    // var headers = {"Content-Type": "application/json"};
    // final http.Response response = await http.put('${ConfigStorage.baseUrl}dm',
    //     body: sscc.toJson(), headers: headers);
    // if (response.statusCode == 200) {
    //   print(response.body);
    //   return SsccModel.fromJson(response.body);
    //   // return data;
    // } else {
    //   // print(response.body);
    //   // response.print('Network connection error');
    //   throw Exception(response.body);
    // }
  }

  Future<SsccModel> getSsccCount(String ssccCode) async {
    request.interceptors.add(BearerInterceptor(oauth));
    var response = await request.get('${ConfigStorage.baseUrl}sscc/$ssccCode');
    return SsccModel.fromJson(response.toString());

    // var headers = {"Content-Type": "application/json"};
    // final http.Response response = await http
    //     .get('${ConfigStorage.baseUrl}sscc/$ssccCode', headers: headers);
    // if (response.statusCode == 200) {
    //   return SsccModel.fromJson(response.body);
    // } else {
    //   print('Network connection error');
    //   NetworkException();
    //   return null;
    // }
  }

  Future<SsccModel> getEanCount(String eanCode) async {
    request.interceptors.add(BearerInterceptor(oauth));
    var response = await request.get('${ConfigStorage.baseUrl}ean/$eanCode');
    return SsccModel.fromJson(response.toString());

    // var headers = {"Content-Type": "application/json"};
    // final http.Response response = await http
    //     .get('${ConfigStorage.baseUrl}ean/$eanCode', headers: headers);
    // if (response.statusCode == 200) {
    //   print(response.body);
    //   return SsccModel.fromJson(response.body);
    // } else {
    //   print('Network connection error');
    //   NetworkException();
    //   return null;
    // }
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

  Future<void> addPackList(PackList pl) async {
    print('request:');
    print('${pl.toJson()}');
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http.post(
        '${ConfigStorage.baseUrl}packlist',
        body: pl.toJson(),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      return null;
      // return data;
    } else {
      // print(response.body);
      // response.print('Network connection error');
      throw Exception(response.body);
    }
  }

  Future<List<String>> getPackListById(String packList) async {
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http
        .get('${ConfigStorage.baseUrl}packlist/$packList', headers: headers);
    if (response.statusCode == 200) {
      var plList = (json.decode(response.body) as List)
          .map((e) => e['sscc'] as String)
          .toList();
      print(plList);
      return plList;
    } else {
      throw Exception(response.body);
    }
  }
}

class NetworkException implements Exception {}
