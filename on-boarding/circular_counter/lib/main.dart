import 'package:flutter/material.dart';

void main() {
  runApp(const CircularCounter());
}

class CircularCounter extends StatelessWidget {
  const CircularCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Counter(title: 'Circular Counter'),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key, required this.title});
  final String title;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter > 10) {
        _counter = 0;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter < 0) {
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.blue[800], shape: BoxShape.circle),
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton(
                    onPressed: _decrementCounter, child: Text("Decrement")),
                SizedBox(width: 20),
                FilledButton(
                    onPressed: _incrementCounter, child: Text("Increment"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
