class CustomException implements Exception {
  const CustomException({this.message = 'エラーが発生しました'});
  final String? message;

  @override
  String toString() => 'CustomException { message: $message }';
}
