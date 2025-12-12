class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class DataException implements Exception {
  final String message;
  DataException(this.message);
}
