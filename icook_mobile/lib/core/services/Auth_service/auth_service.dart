import 'dart:convert';

import 'package:icook_mobile/core/constants/api_routes.dart';
import 'package:icook_mobile/core/services/Api/ApiService.dart';
import 'package:icook_mobile/core/services/key_storage/key_storage_service.dart';
import 'package:icook_mobile/models/requests/Auth/fb_google.dart';
import 'package:icook_mobile/models/requests/Auth/resetpassword.dart';
import 'package:icook_mobile/models/requests/Auth/unlinkgoogle_facbook.dart';
import 'package:icook_mobile/models/requests/Auth/updatepassword.dart';
import 'package:icook_mobile/models/requests/login.dart';
import 'package:icook_mobile/models/requests/signup.dart';
import 'package:icook_mobile/models/response/Auth/login.dart';
import 'package:icook_mobile/models/response/Auth/signup.dart';
import '../../../locator.dart';

abstract class AuthService {
  ///User signin with local details{Post}
  Future<LoginResponse> login(LoginRequest request);

  ///User signup with local details{Post}
  Future<SignUpResponse> signUp(SignUpRequest request);

  ///User signup/login with google{Post}
  Future<dynamic> googleAuth(FbGoogleRequest request);

  ///user signup/login with facebook {Post}
  Future<dynamic> facebookAuth(FbGoogleRequest request);

  ///update user password{Put}
  Future<dynamic> updatePassword(UpdatePasswordRequest request);

  ///forget password{Post}
  Future<dynamic> forgotPassword(String email);

  ///reset password with token{patch}
  Future<dynamic> resetPasswordWithToken(
      ResetPasswordRequest request, String token);

  ///unlink Google oauth{patch}
  Future<dynamic> unlinkGoogle(UnlinkRequest request);

  ///unlink facebook oauth{patch}
  Future<dynamic> unlinkFacebook(UnlinkRequest request);
}

class AuthServiceImpl extends AuthService {
  final api = locator<ApiService>();
  final key = locator<KeyStorageService>();

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    try {
      final response =
          await api.post('${ApiRoutes.signin}', headers, request.toMap());
      print('signin response $response');
      LoginResponse user = LoginResponse.fromJson(response);
      print(user);
      return user;
    } catch (e) {
      print('exception $e');
      throw (e);
    }
  }

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    try {
      final response =
          await api.post('${ApiRoutes.signup}', headers, request.toMap());
      print('signup response $response');
      SignUpResponse user = SignUpResponse.fromJson(response);
      print(user);
      return user;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<dynamic> facebookAuth(FbGoogleRequest request) async {
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    try {
      final response =
          await api.post('${ApiRoutes.facebookauth}', headers, request.toMap());
      print('facebook response $response');
      final res = jsonDecode(response);
      print(res);
      return res;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<dynamic> forgotPassword(String email) async {
    final request = <String, String>{"email": email};
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    try {
      final response =
          await api.post('${ApiRoutes.facebookauth}', headers, request);
      print('forgotpasword response $response');
      final res = jsonDecode(response);
      print(res);
      return res;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<dynamic> googleAuth(FbGoogleRequest request) async {
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    try {
      final response =
          await api.post('${ApiRoutes.facebookauth}', headers, request.toMap());
      print('google response $response');
      final res = jsonDecode(response);
      print(res);
      return res;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<dynamic> resetPasswordWithToken(
      ResetPasswordRequest request, String token) async {
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final url = '${ApiRoutes.resetPassword}/:$token';
    try {
      final response = await api.patch(url, headers, request.toMap());
      print('google response $response');
      final res = jsonDecode(response);
      print(res);
      return res;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<dynamic> unlinkFacebook(UnlinkRequest request) async {
    final token = key.token ?? "";
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "$token"
    };

    final url = '${ApiRoutes.unlinkFacebook}';
    try {
      final response = await api.patch(url, headers, request.toMap());
      print('unlink google response $response');
      final res = jsonDecode(response);
      print(res);
      return res;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<dynamic> unlinkGoogle(UnlinkRequest request) async {
    final token = key.token ?? "";
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "$token"
    };

    final url = '${ApiRoutes.unlinkGoogle}';
    try {
      final response = await api.patch(url, headers, request.toMap());
      print('unlink google response $response');
      final res = jsonDecode(response);
      print(res);
      return res;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<dynamic> updatePassword(UpdatePasswordRequest request) async {
    final token = key.token ?? "";
    final headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "$token"
    };
    try {
      final response = await api.put('${ApiRoutes.updatepassword}', headers,
          body: request.toMap());
      print('signup response $response');
      final res = jsonDecode(response);
      print(res);
      return res;
    } catch (e) {
      throw (e);
    }
  }
}
