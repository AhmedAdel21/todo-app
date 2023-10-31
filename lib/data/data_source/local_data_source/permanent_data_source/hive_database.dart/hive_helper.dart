enum HiveDataBaseExceptionsType {
  dataBaseNotInt(5000),
  none(-5000);

  final int message;
  const HiveDataBaseExceptionsType(this.message);
}

class HiveDataBaseException implements Exception {
  final HiveDataBaseExceptionsType message;
  HiveDataBaseException([this.message = HiveDataBaseExceptionsType.none]);

  @override
  String toString() => "HiveDataBaseException: ${message.message}";
}
