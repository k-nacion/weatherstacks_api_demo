import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

class NoInternetFailure extends Failure {}

class CacheFailure extends Failure {}

class ServerUnreachableFailure extends Failure {}
