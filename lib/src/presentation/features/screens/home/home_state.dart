part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.selectedCallingCode = mockedCallingCode,
    this.phone = '',
  });

  final CallingCode selectedCallingCode;
  final String phone;

  HomeState copyWith({
    CallingCode? selectedCallingCode,
    String? phone,
  }) {
    return HomeState(
      selectedCallingCode: selectedCallingCode ?? this.selectedCallingCode,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object> get props => [
        selectedCallingCode,
        phone,
      ];
}
