// lib/core/network/connectivity_service.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetStatus { online, offline }

class ConnectivityService {
  ConnectivityService._() {
    _sub = Connectivity().onConnectivityChanged.listen((event) {
      final s = event == ConnectivityResult.none
          ? NetStatus.offline
          : NetStatus.online;
      _controller.add(s);
    });
  }
  static final instance = ConnectivityService._();

  late final StreamSubscription _sub;
  final _controller = StreamController<NetStatus>.broadcast();

  Stream<NetStatus> get stream => _controller.stream;

  void dispose() {
    _sub.cancel();
    _controller.close();
  }
}
