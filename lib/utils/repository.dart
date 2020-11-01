import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tsd/models/packList.dart';
import 'package:tsd/models/sscc.dart';
import 'package:tsd/models/ssccModel.dart';
import 'authentication/auth_dio.dart';
import 'constants.dart';
import 'moor/moor_database.dart';

class DataRepository {
  final AppDatabase db;
  DataRepository(this.db);
  var oauth = OAuth(
      clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');
  var request = Dio();

  Future<SsccModel> addSscc(Sscc sscc, bool isOnline) async {
    print('${sscc.toJson()}');
    // Если приложение онлайн, то делаем запрос к серверу
    if (isOnline) {
      request.interceptors.add(BearerInterceptor(oauth));
      try {
        var response = await request.put('${ConfigStorage.baseUrl}dm',
            data: sscc.toJson());
        print('response: $response');
        return SsccModel.fromJson(response.toString());
      } on DioError catch (e) {
        if (e.type == DioErrorType.RESPONSE) {
          print('error description:');
          print(e.response);
          throw e.response;
        }
      }
    }

    //Иначе отправляем в БД
    else {
      final ssccdb = SsccOutCompanion(
          sscc: Value(sscc.sscc),
          ean: Value(sscc.ean),
          isUsed: Value(sscc.isUsed),
          datamatrix: Value(sscc.datamatrix),
          createdAt: Value(DateTime.now().toString()),
          updatedAt: Value(DateTime.now().toString()));
      final Sscc ssccIn =
          Sscc(sscc: sscc.sscc, ean: sscc.ean, datamatrix: sscc.datamatrix);
      //Блок проверок на коды
      SsccInData ssccInDb = await db.ssccInDao.getSsccIn(ssccIn);

      if (ssccInDb == null)
        throw 'Datamatrix не найден';
      else if (ssccInDb.ean != ssccIn.ean)
        throw 'Datamatrix не соответствует EAN';
      else {
        try {
         await db.ssccOutDao.insertSscc(ssccdb);
        } catch (e) {
          throw 'Datamatrix уже был использован';
        }

        // Делаем подсчет SSCC и EAN
        int ssccCount = await db.ssccOutDao.getSsccCount(sscc) ?? 0;
        int eanCount = await db.ssccOutDao.getSsccCount(sscc) ?? 0;
        return SsccModel(
            eanDescription: "", ssccCount: ssccCount, eanCount: eanCount);
      }
    }
  }

  Future<SsccModel> getSsccCount(String ssccCode, bool isOnline) async {
    // Если приложение онлайн, то делаем запрос к серверу
    if (isOnline) {
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
    }
//Иначе к БД
    else {
      Sscc sscc = Sscc(sscc: ssccCode);
      final int _ssccCount = await db.ssccOutDao.getSsccCount(sscc) ?? 0;
      SsccModel ssccModel = SsccModel(ssccCount: _ssccCount);
      return ssccModel;
    }
  }

  Future<SsccModel> getEanCount(
      String ssccCode, String eanCode, bool isOnline) async {
    //Определения языка для EAN
    String lang =
        Settings.getValue<String>('language', 'ru') == 'ru' ? 'RU' : 'EN';

    // Если приложение онлайн, то делаем запрос к серверу
    if (isOnline) {
      request.interceptors.add(BearerInterceptor(oauth));
      try {
        var response = await request.get('${ConfigStorage.baseUrl}ean',
            queryParameters: {'sscc': ssccCode, 'ean': eanCode, 'lang': lang});
        return SsccModel.fromJson(response.toString());
      } on DioError catch (e) {
        if (e.type == DioErrorType.RESPONSE) {
          print('error description:');
          print(e.response);
          throw e.response;
        }
      }
    }

//Иначе к БД
    else {
      Sscc sscc = Sscc(sscc: ssccCode, ean: eanCode);
      final int _ssccCount = await db.ssccOutDao.getSsccCount(sscc) ?? 0;
      final int _eanCount = await db.ssccOutDao.getSsccCount(sscc) ?? 0;
      try {
        Material _materialName =
            await db.materialDao.getMaterialName(sscc, lang);
        print(_materialName);
        SsccModel ssccModel = SsccModel(
            ssccCount: _ssccCount,
            eanCount: _eanCount,
            eanDescription: _materialName.description);
        return ssccModel;
      } catch (e) {
        print('e: $e');
      }
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
      var materialList =
          (response.data as List).map((e) => Material.fromJson(e)).toList();
      return materialList;
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        print('error description:');
        print(e.response);
        throw e.response;
      }
    }
  }

  Future<List<SsccInData>> getSsccc() async {
    request.interceptors.add(BearerInterceptor(oauth));
    Response response = await request.get('${ConfigStorage.baseUrl}dm');

    var dmList =
        (response.data as List).map((e) => SsccInData.fromJson(e)).toList();
    return dmList;
  }
}
