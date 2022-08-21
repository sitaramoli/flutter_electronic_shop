import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:electronic_shop/app/check_connection/i_connection_status.dart';

class ConnectionStatus implements IConnectionStatus {
  final Connectivity _connectivity;
  ConnectionStatus(this._connectivity);
  @override
  Future<bool> get hasConnection async {
    var connection = await _connectivity.checkConnectivity();
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
