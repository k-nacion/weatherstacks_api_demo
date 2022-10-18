import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get hasInternet;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;

  const NetworkInfoImpl({
    required InternetConnectionChecker internetConnectionChecker,
  }) : _internetConnectionChecker = internetConnectionChecker;

  @override
  Future<bool> get hasInternet async => await _internetConnectionChecker.hasConnection;
}
