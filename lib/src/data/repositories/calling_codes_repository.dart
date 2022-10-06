import 'package:injectable/injectable.dart';
import 'package:phone_number_validation/src/data/services/calling_code_service.dart';
import 'package:phone_number_validation/src/domain/entities/calling_code.dart';
import 'package:phone_number_validation/src/domain/repositories/calling_codes_repository.dart';

@LazySingleton(as: CallingCodesRepository)
class CallingCodesRepositoryImpl implements CallingCodesRepository {
  CallingCodesRepositoryImpl(this._callingCodeService);

  final CallingCodeService _callingCodeService;

  @override
  Future<List<CallingCode>> getCallingCodes() async {
    try {
      final data = await _callingCodeService.getCallingCodes();

      List<CallingCode> listCallingCodes = [];
      for (var element in data) {
        final flag = element['flag'];
        final root = element['idd']['root'] ?? '+1';
        final suffixes = element['idd']['suffixes'] ?? [];
        final suffix = suffixes.isNotEmpty ? suffixes.first : '';
        final code = suffix.length < 3 ? root + suffix : root;
        final country = element['name']['common'];
        final callingCode =
            CallingCode(flag: flag, callingCode: code, country: country);

        listCallingCodes.add(callingCode);
      }
      return listCallingCodes;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
