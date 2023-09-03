import 'package:dio/dio.dart';

class Apis {
  static const baseUrl = 'https://event-flutter-demo.glitch.me';

  static BaseOptions baseDioConfigWithoutToken = BaseOptions(
    baseUrl: baseUrl
  );
}