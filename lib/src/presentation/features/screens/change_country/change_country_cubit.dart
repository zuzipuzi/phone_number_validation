import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_number_validation/src/domain/entities/calling_code.dart';
import 'package:phone_number_validation/src/domain/repositories/calling_codes_repository.dart';
import 'package:phone_number_validation/src/presentation/features/utils/logger.dart';

part 'change_country_state.dart';

@Injectable()
class ChangeCountryCubit extends Cubit<ChangeCountryState> {
  ChangeCountryCubit(this._callingCodesRepository)
      : super(const ChangeCountryState());

  final CallingCodesRepository _callingCodesRepository;

  final logger = getLogger('ChangeCountryCubit');

  Future<void> initParams() async {
    try {
      final callingCodeList = await _callingCodesRepository.getCallingCodes();
      emit(state.copyWith(callingCodeList: callingCodeList));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  void searchCodes(String countryName) {
    try {
      List<CallingCode> codes = [];
      for (var code in state.callingCodeList) {
        if (code.country.toLowerCase().contains(countryName.toLowerCase()) ||
            code.callingCode
                .toLowerCase()
                .contains(countryName.toLowerCase())) {
          codes.add(code);
        }
      }

      emit(state.copyWith(searchedCallingCodes: codes));
      emit(state.copyWith(countryName: countryName));
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
