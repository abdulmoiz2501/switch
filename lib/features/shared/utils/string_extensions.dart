extension StringValidators on String {
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(this);
  }


  bool get isNotEmptyField => trim().isNotEmpty;
}
