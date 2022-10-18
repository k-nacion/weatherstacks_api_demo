import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/network/domain/entities/network.dart';

abstract class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

class NoInternetFailure extends NetworkFailure {
  final Network? network;

  const NoInternetFailure({this.network, super.message});

  @override
  List<Object?> get props => [network, super.message];
}
