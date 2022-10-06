import 'package:equatable/equatable.dart';

const mockedCallingCode = CallingCode(
  flag: "\uD83C\uDDFA\uD83C\uDDE6",
  callingCode: "+380",
  country: "Ukraine",
);

class CallingCode extends Equatable {
  const CallingCode({
    required this.flag,
    required this.callingCode,
    required this.country,
  });

  final String flag;
  final String callingCode;
  final String country;

  CallingCode copyWith(
    String? flag,
    String? callingCode,
    String? country,
  ) {
    return CallingCode(
      flag: flag ?? this.flag,
      callingCode: callingCode ?? this.callingCode,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [
        flag,
        callingCode,
        country,
      ];

  Map<String, dynamic> toMap() {
    return {
      'flag': flag,
      'callingCode': callingCode,
      'country': country,
    };
  }

  factory CallingCode.fromMap(Map<String, dynamic> map) {
    return CallingCode(
      flag: map['flag'] as String,
      callingCode: map['callingCodes'] as String,
      country: map['name'] as String,
    );
  }
}
