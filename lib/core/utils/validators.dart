class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    
    if (!RegExp(emailPattern).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    
    return null;
  }

  static String? validateDiceCount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Dice count is required';
    }
    
    int? count = int.tryParse(value);
    if (count == null) {
      return 'Must be a valid number';
    }
    
    if (count < 1 || count > 10) {
      return 'Dice count must be between 1 and 10';
    }
    
    return null;
  }

  static String? validateDiceSides(String? value) {
    if (value == null || value.isEmpty) {
      return 'Dice sides is required';
    }
    
    int? sides = int.tryParse(value);
    if (sides == null) {
      return 'Must be a valid number';
    }
    
    if (sides < 4 || sides > 20) {
      return 'Dice sides must be between 4 and 20';
    }
    
    return null;
  }

  static bool isValidEmail(String email) {
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(emailPattern).hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    return phone.length >= 10;
  }

  static bool isValidName(String name) {
    return name.isNotEmpty && name.length >= 2;
  }
}