import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/user.dart';
import 'package:movie/domain/entities/user_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final Dio dio = Dio();
  final String userUrl = 'https://dummyjson.com/auth/me';

  Future<UserDetailEntity> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = await dio.get(
        userUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await prefs.getString('accessToken')}'
          },
        ),
      );
      return UserDetailEntity.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw ('Sesi Anda telah habis, silahkan login ulang');
      } else {
        throw Exception('Terjadi kesalahan: ${e.message}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
