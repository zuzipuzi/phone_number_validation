// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:phone_number_validation/src/di/modules/network_module.dart' as _i3;
import 'package:phone_number_validation/src/data/repositories/calling_codes_repository.dart'
    as _i6;
import 'package:phone_number_validation/src/data/services/calling_code_service.dart'
    as _i4;
import 'package:phone_number_validation/src/domain/repositories/calling_codes_repository.dart'
    as _i5;
import 'package:phone_number_validation/src/presentation/features/screens/change_country/change_country_cubit.dart'
    as _i7;
import 'package:phone_number_validation/src/presentation/features/screens/home/home_cubit.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.Api>(() => _i3.Api());
  gh.lazySingleton<_i4.CallingCodeService>(
      () => _i4.CallingCodeService(get<_i3.Api>()));
  gh.lazySingleton<_i5.CallingCodesRepository>(
      () => _i6.CallingCodesRepositoryImpl(get<_i4.CallingCodeService>()));
  gh.factory<_i7.ChangeCountryCubit>(
      () => _i7.ChangeCountryCubit(get<_i5.CallingCodesRepository>()));
  gh.lazySingleton<_i8.HomeCubit>(() => _i8.HomeCubit());
  return get;
}
