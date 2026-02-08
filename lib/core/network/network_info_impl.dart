import 'network_info.dart';
import 'connectivity_service.dart';

class NetworkInfoImpl implements NetworkInfo {
  final ConnectivityService connectivityService;

  NetworkInfoImpl(this.connectivityService);

  @override
  Future<bool> get isConnected async {
    return await connectivityService.checkConnection();
  }
}
