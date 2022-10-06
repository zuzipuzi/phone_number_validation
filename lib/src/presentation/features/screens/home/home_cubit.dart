import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:phone_number_validation/src/domain/entities/calling_code.dart';
import 'package:phone_number_validation/src/presentation/features/utils/logger.dart';

part 'home_state.dart';

@LazySingleton()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final logger = getLogger('HomeCubit');

  void onPhoneChanged(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void onCodeChanged(CallingCode callingCode) {
    emit(state.copyWith(selectedCallingCode: callingCode));
    logger.i(state.selectedCallingCode);
  }
}
