import 'package:flutter/material.dart';
import 'package:phone_number_validation/src/domain/entities/calling_code.dart';

class ListBuilderWidget extends StatelessWidget {
  const ListBuilderWidget({
    Key? key,
    required this.listCodes,
    required this.onCountrySelected,
  }) : super(key: key);

  final List<CallingCode> listCodes;
  final Function(CallingCode) onCountrySelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listCodes.length,
      itemBuilder: (context, index) =>
          _buildCallingCodes(context, index: index),
    );
  }

  Widget _buildCallingCodes(BuildContext context, {required int index}) {
    return GestureDetector(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                listCodes.elementAt(index).flag,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(89, 76, 116, 1),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                listCodes.elementAt(index).callingCode,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(89, 76, 116, 1),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 240,
                child: Text(
                  listCodes.elementAt(index).country,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
      onTap: () {
        onCountrySelected(listCodes.elementAt(index));
        Navigator.pop(context);
      },
    );
  }
}
