import 'package:dio/dio.dart';
import 'package:movie/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio dio = Dio();
  final String loginUrl = 'https://dummyjson.com/auth/login';

  Future<UserEntity> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.post(
        loginUrl,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final user = UserEntity.fromJson(response.data);

        // Simpan access token ke SharedPreferences
        await prefs.setString('accessToken', user.accessToken);
        await prefs.setBool('is_login', true);
        return user;
      } else {
        throw ('Terjadi kesalahan, coba lagi nanti.');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw ('Username atau password salah.');
        } else if (e.response!.statusCode == 500) {
          throw ('Terjadi kesalahan pada server.');
        } else {
          throw ('Error: ${e.response!.statusMessage}');
        }
      } else {
        throw ('Tidak ada koneksi internet.');
      }
    } catch (e) {
      throw ('Kesalahan tidak terduga: ${e.toString()}');
    }
  }
}
