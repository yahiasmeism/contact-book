abstract interface class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFalure extends Failure {
  ServerFalure({required super.message});
}

class EmptyChacheFailure extends Failure {
  EmptyChacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}
