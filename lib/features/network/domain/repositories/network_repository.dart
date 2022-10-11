import 'package:fpdart/fpdart.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/network/domain/entities/network.dart';

abstract class NetworkRepository {
  Future<Either<Failure, Network>> hasConnection();
}
