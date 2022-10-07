import 'package:injectable/injectable.dart';
import 'package:phone_number_validation/src/di/modules/network_module.dart';

@LazySingleton()
class CallingCodeService {
  CallingCodeService(this.api);

  final Api api;

  static const baseUrl = 'https://restcountries.com';
  static const version = '/v3.1';
  static const getAllCodes = '/all';

  Future<List<dynamic>> getCallingCodes() async {
    final response = await api.provideApi().get('$baseUrl$version$getAllCodes');

    return response.data;
  }
}
