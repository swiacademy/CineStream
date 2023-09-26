class ErrorNetwork implements Exception {
  final String errorMessage;

  ErrorNetwork(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
