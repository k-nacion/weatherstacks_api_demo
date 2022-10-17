import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/features/network/data/data_sources/network_data_source.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  group('NetworkDataSourceImpl', () {
    late NetworkDataSourceImpl sut;
    late MockInternetConnectionChecker mockInternetConnectionChecker;

    setUp(() {
      mockInternetConnectionChecker = MockInternetConnectionChecker();
      sut = NetworkDataSourceImpl(connectionChecker: mockInternetConnectionChecker);
    });

    group('hasInternetConnection getter', () {
      test(
        'should be a delegate of hasConnection getter from internet connection checker package. Expected result is true ',
        () async {
          when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => true);

          final actual = await sut.hasInternetConnection;

          expect(actual, isTrue);
          verify(() => mockInternetConnectionChecker.hasConnection);
        },
      );

      test(
        'should be a delegate of hasConnection getter from internet connection checker package. Expected result is false.',
        () async {
          when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => false);

          final actual = await sut.hasInternetConnection;

          expect(actual, isFalse);
          verify(() => mockInternetConnectionChecker.hasConnection);
        },
      );
    });
  });
}
