part of 'change_country_cubit.dart';

class ChangeCountryState extends Equatable {
  const ChangeCountryState({
    this.callingCodeList = const [],
    this.countryName = '',
    this.searchedCallingCodes = const [],
  });

  final List<CallingCode> callingCodeList;
  final String countryName;
  final List<CallingCode> searchedCallingCodes;

  ChangeCountryState copyWith({
    List<CallingCode>? callingCodeList,
    CallingCode? selectedCallingCode,
    String? countryName,
    List<CallingCode>? searchedCallingCodes,
  }) {
    return ChangeCountryState(
      callingCodeList: callingCodeList ?? this.callingCodeList,
      countryName: countryName ?? this.countryName,
      searchedCallingCodes: searchedCallingCodes ?? this.searchedCallingCodes,
    );
  }

  @override
  List<Object> get props => [
        callingCodeList,
        countryName,
        searchedCallingCodes,
      ];
}
