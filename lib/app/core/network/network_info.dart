import 'package:connectivity_plus/connectivity_plus.dart';

import 'i_network_info.dart';

class NetworkInfo implements INetworkInfo {
  final Connectivity _connectivity;
  NetworkInfo(this._connectivity);
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
