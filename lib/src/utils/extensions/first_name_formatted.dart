extension FirstNameFormatted on String {
  String? get firstNameFormatted {
    final firstName = split(' ').first;
    if (firstName.length < 2) {
      return split(' ')[1];
    }
    return firstName;
  }
}
