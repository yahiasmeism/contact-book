import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum NetworkState { init, online, offline }

class NetworkCubit extends Cubit<NetworkState> {
  final connection = InternetConnection();
  late StreamSubscription subscription;
  NetworkCubit() : super(NetworkState.init) {
    subscription = connection.onStatusChange.listen(
      (result) {
        if (result == InternetStatus.connected) {
          emit(NetworkState.online);
        } else {
          emit(NetworkState.offline);
        }
      },
    );
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
