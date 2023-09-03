import 'package:dio/dio.dart';
import 'package:new_first_demo/Models/event.dart';

import '../utils/constant.dart';

class ApiProvider {
  final Dio _dio = Dio(Apis.baseDioConfigWithoutToken);

  Future<List<Event>> fetchEventList() async {
    try {
      Response response = await _dio.get("/events");
      var list = response.data;
      var dataList = List<Event>.from(list.map((item) => Event.fromJson(item as Map<String, dynamic>)).toList());
      return dataList;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}