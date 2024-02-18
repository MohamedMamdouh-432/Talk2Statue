class ServerException implements Exception {
  String exceptionMessage;

  ServerException({required this.exceptionMessage});
}

class LocalException implements Exception {
  String statusMessage;

  LocalException({required this.statusMessage});
}
