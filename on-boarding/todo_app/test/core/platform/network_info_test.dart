// import 'package:connectivity/connectivity.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:todo_app/core/platform/network_info.dart';

// class MockDataConnectionChecker extends Mock implements Connectivity {}

// void main() {
//   late NetworkInfoImpl networkInfo;
//   late Connectivity mockDataConnectionChecker;

//   setUp(() {
//     mockDataConnectionChecker = Connectivity();
//     networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
//   });

//   group('isConnected', () {
//     test(
//       'should forward the call to Connectivity.checkConnectivity()',
//       () async {
//         // arrange
//         final tHasConnectionFuture = Future.value(ConnectivityResult.none);
//         when(mockDataConnectionChecker.checkConnectivity())
//             .thenAnswer((_) => tHasConnectionFuture);
//         // act
//         final result = networkInfo.isConnected;
//         // assert
//         verify(mockDataConnectionChecker.checkConnectivity());
//         expect(result, tHasConnectionFuture);
//       },
//     );
//   });
// }
