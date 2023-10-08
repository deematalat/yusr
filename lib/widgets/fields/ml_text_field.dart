import 'package:flutter/material.dart';

import '../../helper/utils/validator.dart';
import 'input_decoration.dart';


class mlTextField extends StatelessWidget {
  String labelText;
  String? hintText;
  TextEditingController controller = TextEditingController();
  mlTextField(
      {required this.labelText,
        this.hintText,
        required this.controller,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType:TextInputType.phone,
      validator: (value) {
        final errorMessage = customPhoneValidator(value);
        print('Validation result: $errorMessage');
        return errorMessage;
      },
      controller: controller,
      decoration: inputDecoration(labelText, Icons.phone_outlined),
    );
  }
}