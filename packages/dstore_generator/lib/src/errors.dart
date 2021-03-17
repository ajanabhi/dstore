class InvalidSignatureError extends Error {
  final String message;

  InvalidSignatureError(this.message);

  @override
  String toString() => 'InvalidSignatureError(message: $message)';
}
