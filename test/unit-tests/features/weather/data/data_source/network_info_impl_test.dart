import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherstacks_api_demo/features/weather/data/data_source/network_info.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  group('NetworkInfoImplTest', () {
    late NetworkInfoImpl sut;
    late MockInternetConnectionChecker mockInternetConnectionChecker;

    setUp(() {
      mockInternetConnectionChecker = MockInternetConnectionChecker();
      sut = NetworkInfoImpl(internetConnectionChecker: mockInternetConnectionChecker);
    });

    test(
      'should just delegate the method to InternetConnectionChecker package',
      () async {
        when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => true);

        final actual = await sut.hasInternet;

        expect(actual, isTrue);
        verify(() => mockInternetConnectionChecker.hasConnection);
      },
    );

    test(
      'should just delegate the method to InternetConnectionChecker package',
      () async {
        when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => false);

        final actual = await sut.hasInternet;

        expect(actual, isFalse);
        verify(() => mockInternetConnectionChecker.hasConnection);
      },
    );
  });
}
