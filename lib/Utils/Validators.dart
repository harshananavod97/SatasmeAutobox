class Validators {
  static bool _isValidEmail(String input) =>
      RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
              r'*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+'
              '[a-z0-9](?:[a-z0-9-]*[a-z0-9])?')
          .hasMatch(input);

  static String? validateEmail(
    String value,
    String? emailRequiredMessage,
    String? validEmailMessage,
  ) {
    if (value.isEmpty) return emailRequiredMessage;

    if (!_isValidEmail(value)) return validEmailMessage;

    return null;
  }

  static String? validateUserName(
    String value,
    String requiredMessage,
    String minLengthMessage,
  ) {
    if (value.isEmpty) return requiredMessage;

    if (value.length <= 8) return minLengthMessage;

    return null;
  }

  static bool _isValidPassword(String input) {
    return RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&_])[A-Za-z\d@$!%*#?&_]{6,20}$')
        .hasMatch(input);
  }

  /// Method to validate a password with custom error messages
  static String? validPassword(
    String value,
    String? passwordRequiredMessage,
    String? validPasswordMessage,
  ) {
    if (value.isEmpty) return passwordRequiredMessage;

    if (!_isValidPassword(value)) return validPasswordMessage;

    return null;
  }

  static bool isValidEmail(String value) {
    if (value.isEmpty) return false;

    return _isValidEmail(value);
  }

  static bool isValidName(String value) {
    if (value.isEmpty) return false;

    return RegExp(r'^[a-zA-Z ]+$').hasMatch(value);
  }

  static bool isCorrectMobileNumber(String value) {
    if (value.isEmpty) return false;

    return RegExp(r'^[0-9]+$').hasMatch(value);
  }
}

extension StringExtension on String? {
  static String urlPattern =
      r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';

  static String phonePattern = r'^[0-9]{9,10}$';

  static String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String pricePattern = r'^\d+$';

  bool hasMatch(String? s, String p) {
    return (s == null) ? false : RegExp(p).hasMatch(s);
  }

  bool validateEmail() => hasMatch(this, emailPattern);

  /// Check phone validation
  bool validatePhone() => hasMatch(this, phonePattern);

  /// Check URL validation
  bool validateURL() => hasMatch(this, urlPattern);

  bool validatePrice() => hasMatch(this, pricePattern);

  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  /// Capitalize given String
  // String capitalizeFirstLetter() => (validate().length >= 1) ? (this!.substring(0, 1).toUpperCase() + this!.substring(1).toLowerCase()) : validate();

  String capitalizeFirstLetter() {
    final String str = validate();

    // Split the string into words, capitalize each word, and join them back together
    return str
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }

  // Check null string, return given value if null
  String validate({String value = ''}) {
    if (this.isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  String splitBefore(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    var matchIterator = pattern.allMatches(this.validate()).iterator;

    Match? match;
    while (matchIterator.moveNext()) {
      match = matchIterator.current;
    }

    if (match != null) {
      return this.validate().substring(0, match.start);
    }
    return '';
  }

  String splitAfter(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    var matchIterator = pattern.allMatches(this!).iterator;

    if (matchIterator.moveNext()) {
      var match = matchIterator.current;
      var length = match.end - match.start;
      return this.validate().substring(match.start + length);
    }
    return '';
  }
}

extension intExtention on int? {
  /// Validate given int is not null and returns given value if null.
  int validate({int value = 0}) {
    return this ?? value;
  }

  /// HTTP status code
  bool isSuccessful() => this! >= 200 && this! <= 206;
}
