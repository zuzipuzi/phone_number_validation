import 'package:phone_number_validation/src/domain/entities/calling_code.dart';

abstract class CallingCodesRepository {
  Future<List<CallingCode>> getCallingCodes();
}
