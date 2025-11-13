import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetNotifier extends Notifier<bool> {
  StreamSubscription? _subscription;

  @override
  bool build() {
    state = false; // initial

    // ✅ check initial connection
    InternetConnection().hasInternetAccess.then((value) {
      state = value;
    });

    // ✅ listen for changes afterwards
    _subscription = InternetConnection().onStatusChange.listen((event) {
      state = event == InternetStatus.connected;
    });

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return state;
  }
}

final internetProvider = StreamProvider<bool>((ref) {
  return InternetConnection()
      .onStatusChange
      .map((event) => event == InternetStatus.connected);
});

