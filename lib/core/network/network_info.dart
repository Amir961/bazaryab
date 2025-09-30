
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection? checker;

  const NetworkInfoImpl({required this.checker});
 // const NetworkInfoImpl();

  @override
 // Future<bool> get isConnected async => true;
  Future<bool> get isConnected async => checker!.hasInternetAccess;
}

class NetworkInfoWebImpl implements NetworkInfo {




  @override
  Future<bool> get isConnected async => true;
}
