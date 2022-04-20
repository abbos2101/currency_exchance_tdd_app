abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  // final DataConnectionChecker connectionChecker;
  //
  // NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async => true; //connectionChecker.hasConnection;
}
