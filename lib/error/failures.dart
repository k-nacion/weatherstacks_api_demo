import 'package:equatable/equatable.dart';
import 'package:weatherstacks_api_demo/features/network/domain/entities/network.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

class NoInternetFailure extends Failure {
  final Network? network;

  const NoInternetFailure({this.network});

  @override
  List<Object?> get props => [network];
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

class ServerUnreachableFailure extends Failure {
  const ServerUnreachableFailure({super.message});
}
