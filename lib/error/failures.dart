import 'package:equatable/equatable.dart';
import 'package:weatherstacks_api_demo/features/network/domain/entities/network.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class NoInternetFailure extends Failure {
  final Network? network;

  const NoInternetFailure({this.network});

  @override
  List<Object?> get props => [network];
}

class CacheFailure extends Failure {}

class ServerUnreachableFailure extends Failure {}
