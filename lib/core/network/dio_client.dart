import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static String? _token;

  static void init({
    required String baseUrl,
    Map<String, dynamic>? defaultHeaders,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 15),
    bool enableLogging = false,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?defaultHeaders,
        },
      ),
    );

    if (enableLogging) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        error: true,
        logPrint: (obj) => print(obj),
      ));
    }
  }

  /// تحديث التوكن (أو حذفه)
  static void updateToken(String? token) {
    _token = token;
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      dio.options.headers.remove('Authorization');
    }
  }

  /// تنفيذ GET مع دعم Query parameters ورؤوس إضافية
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
  }) async {
    _setHeaders(token, headers);
    try {
      return await dio.get(url, queryParameters: query);
    } catch (e) {
      rethrow;
    }
  }

  /// تنفيذ POST مع دعم body data ورؤوس إضافية
  static Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
  }) async {
    _setHeaders(token, headers);
    try {
      return await dio.post(url, data: data, queryParameters: query);
    } catch (e) {
      rethrow;
    }
  }

  /// تنفيذ PUT مع دعم body data ورؤوس إضافية
  static Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
  }) async {
    _setHeaders(token, headers);
    try {
      return await dio.put(url, data: data, queryParameters: query);
    } catch (e) {
      rethrow;
    }
  }

  /// تنفيذ DELETE مع دعم Query parameters ورؤوس إضافية
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
  }) async {
    _setHeaders(token, headers);
    try {
      return await dio.delete(url, queryParameters: query);
    } catch (e) {
      rethrow;
    }
  }


  static Future<Response> uploadFile({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    ProgressCallback? onSendProgress,  // <-- هنا
  }) async {
    final Map<String, String> requestHeaders = {
      'Content-Type': 'multipart/form-data',
      if (token != null) 'Authorization': 'Bearer $token',
      if (headers != null) ...headers,
    };

    try {
      return await dio.post(
        url,
        data: data,
        queryParameters: query,
        options: Options(headers: requestHeaders),
        onSendProgress: onSendProgress,  // <-- تمرير callback نسبة التقدم
      );
    } catch (e) {
      rethrow;
    }
  }


  /// تحديث الرؤوس (headers) بناءً على التوكن ورؤوس إضافية ممررة في الطلب
  static void _setHeaders(String? token, Map<String, String>? headers) {
    // التوكن الممرر في الدالة له الأولوية، ثم التوكن المخزن داخليًا
    final authToken = token ?? _token;

    if (authToken != null && authToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
    } else {
      dio.options.headers.remove('Authorization');
    }

    // إزالة كل الرؤوس الإضافية السابقة (غير الرئيسية) قبل تعيين جديدة
    headers?.forEach((key, value) {
      dio.options.headers[key] = value;
    });
  }
}
