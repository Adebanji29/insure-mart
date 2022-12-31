import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color.dart';
import '../utils/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.label,
    this.width,
    required this.controller,
    this.height = 48,
    this.keyBoardType = TextInputType.name,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.readOnly = false,
    this.suffix,
    this.validator,
    this.focusColor = InsuremartTheme.green2,
    this.maxLength,
    this.onTap,
    this.obscureText = false,
    this.onChanged,
  }) : super(key: key);
  final String? label;
  final double? width;
  final double height;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Widget? suffix;
  final FormFieldValidator? validator;
  final Color focusColor;
  final int? maxLength;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: maxLength != null ? height + 20 : height,
      child: TextFormField(
        controller: controller,
        validator: validator,
        readOnly: readOnly,
        keyboardType: keyBoardType,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        cursorColor: focusColor,
        obscureText: obscureText,
        onTap: onTap,
        onChanged: onChanged,
        decoration: buildTextDecoration(
            label: label, suffix: suffix, focusColor: focusColor),
      ),
    );
  }
}

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.height = 48,
    this.focusColor = InsuremartTheme.green2,
  }) : super(key: key);
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final String? label;
  final double height;
  final Color focusColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DropdownButtonFormField2<String>(
        style: InsuremartTheme.lightTextTheme.bodyText1!
            .copyWith(fontWeight: FontWeight.w400),
        decoration: buildTextDecoration(label: label, focusColor: focusColor),
        icon: const Icon(Icons.expand_more),
        iconOnClick: const Icon(Icons.expand_less),
        alignment: AlignmentDirectional.bottomStart,
        isExpanded: true,
        value: value,
        items: items.map(buildMenuItem).toList(),
        onChanged: onChanged,
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.w400,
            // color: InsuremartTheme.white3,
          ),
        ),
      );
}

InputDecoration buildTextDecoration({
  String? label,
  Widget? suffix,
  Color focusColor = InsuremartTheme.green2,
}) {
  return InputDecoration(
    // helperStyle: InsuremartTheme.lightTextTheme.bodyText1!
    //     .copyWith(fontWeight: FontWeight.w400),
    // counterStyle: InsuremartTheme.lightTextTheme.bodyText1!
    //     .copyWith(fontWeight: FontWeight.w400),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelText: label,
    labelStyle: InsuremartTheme.lightTextTheme.bodyText1!.copyWith(
      fontWeight: FontWeight.w400,
      color: InsuremartTheme.white3,
    ),
    fillColor: InsuremartTheme.white2,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: InsuremartTheme.white3,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 2,
        color: focusColor,
      ),
    ),
    suffixIcon: suffix,
    iconColor: InsuremartTheme.green2,
    suffixIconColor: InsuremartTheme.green2,
    focusColor: focusColor,
  );
}

Column label(String title, {Color? color}) {
  Color colour;
  if (color == null) {
    colour = InsuremartColor.black1.withOpacity(.8);
  } else {
    colour = color;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style:
            InsuremartTheme.lightTextTheme.bodyText1!.copyWith(color: colour),
        textAlign: TextAlign.start,
      ),
      const SizedBox(height: 5)
    ],
  );
}

