class Validators {
static String? passwordValidator(dynamic val) {
  if (val == null || val.isEmpty) {
    return 'Please enter your password';
  }
  if (val.length < 7) {
    return 'Password must be longer than 6 characters';
  }

  return null;
}

static String? emailValidator(dynamic value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your eamil..';
  }
  final emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return "Please enter a valid email";
  }
  return null;
}
}