String? customTextValidator(value) {
  return (value == null || value.isEmpty) ? 'Please Enter First Name' : null;
}

String? customEmailValidator(value) {
  return (!value.isEmpty && !RegExp(r'\S+@\S+\.\S+').hasMatch(value))
      ? 'Please enter a valid email address'
      : null;
}
String? customPhoneValidator(value) {
  final phoneRegex = r'^\d{10}$';
  return (!value.isEmpty && !RegExp(phoneRegex).hasMatch(value))
      ? "Please enter a valid 10-digit phone number"
      : null;
}
String? customPasswordValidator(value) {
  return (!value.isEmpty && value.length < 8)
      ? "Please enter a valid 10-digit phone number"
      : null;
}