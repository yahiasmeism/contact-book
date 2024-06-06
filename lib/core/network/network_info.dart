import "dart:async";

import "package:internet_connection_checker_plus/internet_connection_checker_plus.dart";

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection _connection = InternetConnection();

  @override
  Future<bool> get isConnected {
    return _connection.hasInternetAccess;
  }
}
