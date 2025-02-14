import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie/ui/screen/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  DioClient() {
    addInterceptor(AuthInterceptor());
  }

  final Dio dio = Dio(
    BaseOptions(),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}

class AuthInterceptor implements Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (options.headers['requires-token'] == true) {
    //   final prefs = await SharedPreferences.getInstance();
    //   final authToken = prefs.get('auth-token');
    //   options.headers.addAll({"Authorization": "$authToken"});
    // }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    err = DioException(requestOptions: err.requestOptions, error: err.message);
    if (err.response?.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return handler.next(err);
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
// check if the response is in standard format
/* 
The format we want our response might be
{
"success": true/false,
"data":{} or [] or null,
"message": "There is data" or "The data couldnot be found"
}  
Let us validate 
*/
  }
}
