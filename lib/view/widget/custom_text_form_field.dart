import 'package:flutter/material.dart';
import 'package:todoappv1/core/constant/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,
    required this.controller,
     this.onSave,
     this.validator,
    this.onTap,
    this.onChanged,
    required this.autofocus,
    required this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller ;
  final void Function(String?)? onSave ;
  final void Function()? onTap ;
  final String? hintText ;
  final String? Function(String?)? validator ;
  final void Function(String)? onChanged ;
  final bool autofocus  ;
  final TextInputType? keyboardType ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: 3,
      minLines: 1,
      cursorColor: MyColors.primaryOrangeColor,
      style: const TextStyle(
        color: MyColors.tertiaryBlueColor,
      ),
      keyboardType: keyboardType,
      autofocus: autofocus,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      onSaved: onSave,
      onTap: onTap,

      decoration:  InputDecoration(
        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.tertiaryBlueColor,
          ),
        ),
        focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.primaryOrangeColor,
          ),
        ),
          hintText: hintText,
          hintStyle:const TextStyle(
              color: MyColors.tertiaryBlueColor),

      ),
    );
  }
}
