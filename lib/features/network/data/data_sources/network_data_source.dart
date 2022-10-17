import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkDataSource {
  Future<bool> get hasInternetConnection;
}

class NetworkDataSourceImpl implements NetworkDataSource {
  final InternetConnectionChecker _connectionChecker;

  const NetworkDataSourceImpl({
    required InternetConnectionChecker connectionChecker,
  }) : _connectionChecker = connectionChecker;

  @override
  Future<bool> get hasInternetConnection => _connectionChecker.hasConnection;
}
