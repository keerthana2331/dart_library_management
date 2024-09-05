import 'dart:io';

String getValidInput(String prompt, {String Function(String input)? validator}) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input == null || input.trim().isEmpty) {
      print('Input cannot be empty. Please try again.');
    } else if (validator != null) {
      String validationMessage = validator(input.trim());
      if (validationMessage.isNotEmpty) {
        print(validationMessage);
      } else {
        return input.trim();
      }
    } else {
      return input.trim();
    }
  }
}

int getValidIntInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    try {
      return int.parse(input!.trim());
    } catch (e) {
      print('Please enter a valid number.');
    }
  }
}

bool isValidName(String name) {
  final RegExp nameExp = RegExp(r'^[a-zA-Z]+$');
  return nameExp.hasMatch(name);
}

bool isValidIsbn(String isbn) {
  final RegExp isbnExp = RegExp(r'^\d{13}$');
  return isbnExp.hasMatch(isbn);
}
