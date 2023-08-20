import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group("stringToUnsignedInteger", () {
    test(
        "should return an integer when the string represent an unsigned integer",
        () {
      const str = "1";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Right(1));
    });

    test(
        "should return InputInvalidFailure when the string represent an is not unsigned integer",
        () {
      const str = "abc";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });

    test(
        "should return InputInvalidFailure when the string represent an is negative integer",
        () {
      const str = "-1";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
