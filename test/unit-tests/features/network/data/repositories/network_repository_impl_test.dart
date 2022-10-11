import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/error/failures.dart';
import 'package:weatherstacks_api_demo/features/network/data/data_sources/network_data_source.dart';
import 'package:weatherstacks_api_demo/features/network/data/repositories/network_repository_impl.dart';
import 'package:weatherstacks_api_demo/features/network/domain/entities/network.dart';

class MockNetworkDataSource extends Mock implements NetworkDataSource {}

void main() {
  group('Network Repository Impl Test', () {
    late NetworkRepositoryImpl sut;
    late MockNetworkDataSource mockNetworkDataSource;

    setUp(() {
      mockNetworkDataSource = MockNetworkDataSource();
      sut = NetworkRepositoryImpl(networkDataSource: mockNetworkDataSource);
    });

    const Either<Failure, Network> tNetworkSuccess = Right(Network(status: true));
    const Either<Failure, Network> tNetworkFailure = Left(NoInternetFailure(network: Network(status: false)));

    test(
      'should return Network class if there is a network with status value as true.',
      () async {
        when(() => mockNetworkDataSource.hasInternetConnection).thenAnswer((_) async => true);

        final actual = await sut.hasConnection();

        expect(actual, tNetworkSuccess);
        verify(() => mockNetworkDataSource.hasInternetConnection);
      },
    );

    test(
      'should return NoInternetFailure containing Network object with status parameter as false ',
      () async {
        when(() => mockNetworkDataSource.hasInternetConnection).thenAnswer((_) async => false);

        final actual = await sut.hasConnection();

        expect(actual, tNetworkFailure);
        verify(() => mockNetworkDataSource.hasInternetConnection);
      },
    );
  });
}
