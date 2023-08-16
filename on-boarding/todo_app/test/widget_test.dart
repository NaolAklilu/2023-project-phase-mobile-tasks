import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/add_tasks.dart';
import 'package:todo_app/Todo%20Task/presentation/pages/on_boarding.dart';

void main() {
  testWidgets("My Screen has Column widgets", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: AddTask()));

    // Act
    final columns = find.byType(Column);

    // Assert
    expect(columns, findsNWidgets(2));
  });

  testWidgets("My Screen has Divider Widget", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: AddTask()));

    // Act
    final div = find.byType(Divider);

    // Assert
    expect(div, findsOneWidget);
  });

  testWidgets("My Screen has Text Widget", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: AddTask()));

    // Act
    var task = find.text("Main task name");
    var date = find.text("Due Date");
    var description = find.text("Description");

    // Assert
    expect(task, findsOneWidget);
    expect(date, findsOneWidget);
    expect(description, findsOneWidget);
  });

  testWidgets("My Screen has Button Widget", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: AddTask()));

    // Act
    var button = find.byType(ElevatedButton);

    // Assert
    expect(button, findsOneWidget);
  });

  testWidgets("My Screen has Elevated Button Widget",
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: OnBoardingScreen()));

    // Act
    var button = find.byType(ElevatedButton);

    // Assert
    expect(button, findsOneWidget);
  });

  testWidgets("My Screen has Container Widget", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: OnBoardingScreen()));

    // Act
    var container = find.byType(Container);

    // Assert
    expect(container, findsNWidgets(2));
  });

  testWidgets("My Screen has Column Widget", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: OnBoardingScreen()));

    // Act
    var col = find.byType(Column);

    // Assert
    expect(col, findsOneWidget);
  });

  testWidgets("My Screen has Row Widget", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: OnBoardingScreen()));

    // Act
    var row = find.byType(Row);

    // Assert
    expect(row, findsOneWidget);
  });
}
