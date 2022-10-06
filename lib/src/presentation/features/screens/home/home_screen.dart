import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_number_validation/src/domain/entities/calling_code.dart';
import 'package:phone_number_validation/src/presentation/base/cubit/cubit_state.dart';
import 'package:phone_number_validation/src/presentation/base/cubit/host_cubit.dart';
import 'package:phone_number_validation/src/presentation/features/screens/change_country/change_country_cubit.dart';
import 'package:phone_number_validation/src/presentation/features/screens/change_country/change_country_sheet.dart';
import 'package:phone_number_validation/src/presentation/features/screens/home/home_cubit.dart';
import 'package:phone_number_validation/src/presentation/features/utils/logger.dart';
import 'package:phone_number_validation/src/presentation/features/widgets/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const screenName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends CubitState<HomeScreen, HomeState, HomeCubit> {
  final TextEditingController _phoneController = TextEditingController();
  final ValueKey _phoneTextFieldKey = const ValueKey('nameTextFieldKey');

  final logger = getLogger('HomeScreen');

  static const _secondaryColor = Color.fromRGBO(244, 245, 255, 0.4);
  static const _onSecondaryColor = Color.fromRGBO(89, 76, 116, 1);
  static const _backgroundColor = Color.fromRGBO(142, 170, 251, 1);

  @override
  void initParams(BuildContext context) {
    final state = cubit(context).state;

    _phoneController
      ..text = state.phone
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length))
      ..addListener(() {
        cubit(context).onPhoneChanged(_phoneController.text);
      });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(),
      backgroundColor: _backgroundColor,
      body: observeState(builder: (context, state) => _buildHomeBody()),
    );
  }

  Widget _buildHomeBody() {
    return observeState(
      builder: (context, state) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text("Get Started",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Colors.white)),
              const SizedBox(height: 160),
              Row(
                children: [
                  _buildCountryCodeChangeButton(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFieldWidget(
                      key: _phoneTextFieldKey,
                      controller: _phoneController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 160),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return observeState(
      builder: (context, state) => Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            color: state.phone.length == 14 ? Colors.white : _secondaryColor,
            borderRadius: BorderRadius.circular(16)),
        child: IconButton(
          onPressed: state.phone.length == 14
              ? () => logger.i(
                  "Number phone: ${state.selectedCallingCode.callingCode}${state.phone}")
              : () {},
          icon: SvgPicture.asset(
            "assets/images/Fill.svg",
            color: state.phone.length == 14
                ? _onSecondaryColor
                : const Color.fromRGBO(120, 134, 184, 1),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryCodeChangeButton() {
    return observeState(
      builder: (context, state) => ElevatedButton(
        onPressed: () => _showBottomSheet(context),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(71, 48),
          backgroundColor: _secondaryColor,
          shadowColor: _secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text(
          '${state.selectedCallingCode.flag} ${state.selectedCallingCode.callingCode}',
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _onSecondaryColor),
        ),
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext homeScreenContext) {
    return showModalBottomSheet(
      backgroundColor: _backgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) => HostCubit<ChangeCountryCubit>(
        child: ChangeCountrySheet(
          onCountrySelected: (CallingCode callingCode) {
            cubit(homeScreenContext).onCodeChanged(callingCode);
          },
        ),
      ),
    );
  }
}
