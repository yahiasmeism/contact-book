abstract interface class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class EmptyChacheFailure extends Failure {
  EmptyChacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required super.message});
}
