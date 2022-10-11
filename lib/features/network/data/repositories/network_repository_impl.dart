import 'package:fpdart/src/either.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/network/data/data_sources/network_data_source.dart';
import 'package:weatherstacks_api_demo/features/network/domain/entities/network.dart';
import 'package:weatherstacks_api_demo/features/network/domain/repositories/network_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final NetworkDataSource _networkDataSource;

  const NetworkRepositoryImpl({
    required NetworkDataSource networkDataSource,
  }) : _networkDataSource = networkDataSource;

  @override
  Future<Either<Failure, Network>> hasConnection() async {
    final hasInternet = await _networkDataSource.hasInternetConnection;

    return hasInternet ? const Right(Network(status: true)) : const Left(NoInternetFailure(network: Network(status: false)));
  }
}
