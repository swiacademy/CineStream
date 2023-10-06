class LimitChar {
  static String limitCharacters(String input) {
    if (input.length <= 15) {
      return input;
    } else {
      return "${input.substring(0, 15)}...";
    }
  }
}
