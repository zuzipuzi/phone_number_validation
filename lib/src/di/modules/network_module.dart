import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class Api {
  static const timeOut = 60000;

  Dio provideApi() => Dio(dioOptions);

  BaseOptions get dioOptions => BaseOptions(
        connectTimeout: timeOut,
        receiveTimeout: timeOut,
        sendTimeout: timeOut,
      );
}
