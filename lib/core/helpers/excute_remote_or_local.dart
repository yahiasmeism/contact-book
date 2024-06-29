import 'dart:async';

import 'package:contact_book/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

/// A helper function to execute operations either on the remote server or locally.
///
/// This function first checks the network connection status using the provided
/// [networkInfo]. If the device is connected to the internet, it attempts to
/// execute the [remoteCall]. If the [remoteCall] is successful, it returns the result.
/// If the [remoteCall] throws a [ServerException], it catches the exception and
/// returns a [ServerFailure].
///
/// If the device is not connected to the internet, it executes the [localCall] instead
/// and returns the result of the [localCall].
///
/// This function is useful for operations that can be performed both remotely and
/// locally, and it helps to reduce code duplication by centralizing the network
/// connectivity check and error handling.
///
/// Example usage:
///
/// ```dart
/// Future<Either<Failure, List<ContactEntity>>> getAllContacts() async {
///   return executeRemoteOrLocal(
///     remoteCall: () => contactRemote.getAllContacts(),
///     localCall: () => contactLocal.getAllContacts(),
///   );
/// }
/// ```
///
/// Parameters:
/// - [remoteCall]: A function that performs the remote operation and returns a [Future] of type [T].
/// - [localCall]: A function that performs the local operation and returns a [Future] of type [T].
///
/// Returns:
/// - A [Future] containing an [Either] with a [Failure] on the left side if the operation fails,
///   or a value of type [T] on the right side if the operation succeeds.
///
/// Throws:
/// - No direct exceptions are thrown, but [ServerException] is caught and handled within the function.
Future<Either<Failure, T>> executeRemoteOrLocal<T>({
  required Future<T> Function() remoteCall,
  required Future<T> Function() localCall,
  required NetworkInfo networkInfo,
}) async {
  if (await networkInfo.isConnected) {
    try {
      return right(await remoteCall());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  } else {
    try {
      return right(await localCall());
    } on DatabaseException catch (e) {
      return left(DatabaseFailure(message: e.message));
    } on EmptyChacheException catch(e){
      return left(EmptyChacheFailure(message: e.message));
    }
  }
}
