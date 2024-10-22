enum PasswordValidationError {
  MissingLowercase,
  MissingUppercase,
  MissingDigit,
  MissingSpecialCharacter,
  TooShort,
  None
}

PasswordValidationError validatePassword(String password) {
  bool hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  bool hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  bool hasDigit = RegExp(r'\d').hasMatch(password);
  bool hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  if (!hasLowercase) {
    return PasswordValidationError.MissingLowercase;
  }

  if (!hasUppercase) {
    return PasswordValidationError.MissingUppercase;
  }

  if (!hasDigit) {
    return PasswordValidationError.MissingDigit;
  }

  if (!hasSpecialCharacter) {
    return PasswordValidationError.MissingSpecialCharacter;
  }

  if (password.length < 8) {
    return PasswordValidationError.TooShort;
  }

  return PasswordValidationError.None;
}