import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<Response> get(String url);
  Future<Response> post(String url, dynamic body);
}

class NetworkServiceImpl implements NetworkService {
  final dio = Dio();
  @override
  Future<Response> get(String url) async {
    final response = await dio.get(url);
    //if(response.statusCode == 401) _goToLoginPage();
    return response;
  }

  @override
  Future<Response> post(String url, dynamic body) async {
    final response = await dio.post(url, data: body);
    return response;
  }
}
