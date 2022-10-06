import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_number_validation/src/domain/entities/calling_code.dart';
import 'package:phone_number_validation/src/presentation/base/cubit/cubit_state.dart';
import 'package:phone_number_validation/src/presentation/features/screens/change_country/change_country_cubit.dart';
import 'package:phone_number_validation/src/presentation/features/utils/logger.dart';
import 'package:phone_number_validation/src/presentation/features/widgets/list_builder_widget.dart';
import 'package:phone_number_validation/src/presentation/features/widgets/text_field_widget.dart';

class ChangeCountrySheet extends StatefulWidget {
  const ChangeCountrySheet({Key? key, required this.onCountrySelected})
      : super(key: key);
  final Function(CallingCode) onCountrySelected;

  static const screenName = '/changeCountrySheet';

  @override
  State<ChangeCountrySheet> createState() => _ChangeCountrySheetState();
}

class _ChangeCountrySheetState extends CubitState<ChangeCountrySheet,
    ChangeCountryState, ChangeCountryCubit> {
  final TextEditingController _countryNameController = TextEditingController();
  final ValueKey _countryNameTextFieldKey =
      const ValueKey('countryNameTextFieldKey');

  final logger = getLogger('ChangeCountrySheet');

  @override
  void initParams(BuildContext context) {
    final state = cubit(context).state;
    if (state.callingCodeList.isEmpty) {
      cubit(context).initParams();
    }

    _countryNameController
      ..text = state.countryName
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _countryNameController.text.length))
      ..addListener(() {
        cubit(context).searchCodes(_countryNameController.text);
      });
  }

  @override
  void dispose() {
    _countryNameController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: observeState(builder: (context, state) => _buildBody()),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return observeState(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Country code',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Colors.white)),
                _buildCloseButton(),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 48,
                child: TextFieldWidget(
                    key: _countryNameTextFieldKey,
                    controller: _countryNameController,
                    phoneField: false)),
            const SizedBox(height: 24),
            state.callingCodeList.isEmpty
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListBuilderWidget(
                      listCodes: _countryNameController.text.isNotEmpty
                          ? state.searchedCallingCodes
                          : state.callingCodeList,
                      onCountrySelected: (CallingCode callingCode) {
                        widget.onCountrySelected(callingCode);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 245, 255, 0.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(6),
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset("assets/images/Union.svg"),
      ),
    );
  }
}
