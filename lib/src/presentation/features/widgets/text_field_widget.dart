import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.phoneField = true,
  }) : super(key: key);

  final TextEditingController controller;
  final bool phoneField;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters:
          phoneField ? [MaskedInputFormatter('(###) ###-####')] : [],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(89, 76, 116, 1),
      ),
      minLines: 1,
      maxLines: 1,
      keyboardType: phoneField ? TextInputType.phone : TextInputType.name,
      decoration: InputDecoration(
        prefixIcon: phoneField
            ? null
            : Container(
                padding: const EdgeInsets.all(17),
                child: SvgPicture.asset("assets/images/Search.svg"),
              ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        hintText: phoneField ? "(123) 123-1234" : "Search",
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(120, 134, 184, 1),
        ),
        fillColor: const Color.fromRGBO(244, 245, 255, 0.4),
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          borderSide: BorderSide(
            color: Color.fromRGBO(244, 245, 255, 0.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          borderSide: BorderSide(
            color: Color.fromRGBO(244, 245, 255, 0.0),
          ),
        ),
      ),
    );
  }
}
