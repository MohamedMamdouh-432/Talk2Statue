  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field can\'t be empty';
    }
    return null; // Return null if the input is valid
  }