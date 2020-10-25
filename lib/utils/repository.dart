import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:tsd/models/packList.dart';
import 'package:tsd/models/sscc.dart' as sModel;
import 'package:tsd/models/ssccModel.dart';

import 'authentication/auth_dio.dart';
import 'constants.dart';
import 'moor/moor_database.dart';

class DataRepository {
  var oauth = OAuth(
      clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');
  var request = Dio();

  Future<SsccModel> addSscc(sModel.Sscc sscc) async {
    print('${sscc.toJson()}');
    request.interceptors.add(BearerInterceptor(oauth));
    try {
      var response =
          await request.put('${ConfigStorage.baseUrl}dm', data: sscc.toJson());
      print('response: $response');
      return SsccModel.fromJson(response.toString());
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print('error description:');
        print(e.response);
        throw e.response;
      }
    }

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
    try {
      var response =
          await request.get('${ConfigStorage.baseUrl}sscc/$ssccCode');
      return SsccModel.fromJson(response.toString());
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print('error description:');
        print(e.response);
        throw e.response;
      }
    }
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

  Future<SsccModel> getEanCount(String sscc, String eanCode) async {
    request.interceptors.add(BearerInterceptor(oauth));

    //Определения языка для EAN
    String lang = Settings.getValue<int>('language', 0) == 0 ? 'RU' : 'EN';
    // request.options.headers['lang'] = lang;

    try {
      var response = await request.get('${ConfigStorage.baseUrl}ean',
          queryParameters: {'sscc': sscc, 'ean' : eanCode, 'lang': lang });
      return SsccModel.fromJson(response.toString());
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print('error description:');
        print(e.response);
        throw e.response;
      }
    }
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
      throw response.body;
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
      throw response.body;
    }
  }

    Future<List<Material>> getMaterials() async {
    request.interceptors.add(BearerInterceptor(oauth));
    try {
      request.interceptors.add(BearerInterceptor(oauth));
     Response response = await request.get('${ConfigStorage.baseUrl}ean');
  var materialList = (response.data as List)
          .map((e) => Material.fromJson(e))
          .toList();
      return materialList;
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print('error description:');
        print(e.response);
        throw e.response;
      }
    }
  
  }

  Future<List<Sscc>> getSsccc() async {
    request.interceptors.add(BearerInterceptor(oauth));
    Response response = await request.get('${ConfigStorage.baseUrl}dm');
    
     var dmList = (response.data as List)
          .map((e) => Sscc.fromJson(e))
          .toList();
      return dmList;

   
  }

}


