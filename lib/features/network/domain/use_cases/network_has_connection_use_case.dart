import 'package:fpdart/fpdart.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/network/domain/entities/network.dart';
import 'package:weatherstacks_api_demo/features/network/domain/repositories/network_repository.dart';

class NetworkHasConnection {
  final NetworkRepository _repository;

  const NetworkHasConnection({
    required NetworkRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, Network>> call() async {
    return await _repository.hasConnection();
  }
}
