import 'package:flutter/material.dart';
import '../../helper/utils/validator.dart';


class mlPasswordField extends StatefulWidget {
  String labelText;
  String? hintText;
  bool passwordVisible;
  Function(String?)? validator;
  TextEditingController controller = TextEditingController();
  mlPasswordField(
      {required this.labelText,
        this.hintText,
        this.passwordVisible = true,
        required this.controller,
        this.validator,
        Key? key})
      : super(key: key);

  @override
  State<mlPasswordField> createState() => _mlPasswordFieldState();
}

class _mlPasswordFieldState extends State<mlPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.passwordVisible,
      validator: (value) { final errorMessage = customPasswordValidator(value);
      print('Validation result: $errorMessage');
      return errorMessage;

      },
      controller: widget.controller,

      decoration: InputDecoration(
        prefixIcon: Icon(
           Icons.lock_open,
          size: 20,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.passwordVisible = !widget.passwordVisible;
            });
          },
          icon: Icon(
              widget.passwordVisible ? Icons.visibility : Icons.visibility_off),
        ),
        labelText: widget.labelText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFF8F8996))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFF0E497A))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFF8F8996))),
      ),
    );
  }
}