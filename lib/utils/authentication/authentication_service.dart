import 'package:dio/dio.dart';
import 'package:tsd/models/user.dart';

import '../constants.dart';
import 'auth_dio.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signIn(String username, String password);
  Future<void> signOut();
}

class UserAuthenticationService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    var oauth = OAuth(
        clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');
    var authenticadedDio = Dio();
    authenticadedDio.interceptors.add(BearerInterceptor(oauth));
    try {
      Response response =
          await authenticadedDio.get('${ConfigStorage.baseUrl}me');

      print(response.data);
      User _user = User.fromJson(response.data);
      print(_user.name);
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      print('error: $e');
      return null;
    }
  }

  @override
  Future<User> signIn(String username, String password) async {
    var oauth = OAuth(
        clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');
    try {
      var token = await oauth
          .requestToken(PasswordGrant(username: username, password: password));
      print('AccessToken from request: ${token.accessToken}');

      final User user = await getCurrentUser();
      return user;
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        throw Exception('Неправильная учетная запись или пароль');
      }
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await OAuthMemoryStorage().clear();
  }
}
