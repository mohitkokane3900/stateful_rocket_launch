import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LaunchController(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LaunchController extends StatefulWidget {
  const LaunchController({super.key});

  @override
  State<LaunchController> createState() => _LaunchControllerState();
}

class _LaunchControllerState extends State<LaunchController> {
  int _counter = 0;

  void _ignite() {
    setState(() {
      if (_counter < 100) _counter++;
    });
  }

  void _abort() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  Color _numberColor() {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rocket Launch Controller')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_counter',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w700,
              color: _numberColor(),
            ),
          ),
          const SizedBox(height: 24),
          Slider(
            min: 0,
            max: 100,
            divisions: 100,
            value: _counter.toDouble(),
            onChanged: (v) {
              setState(() {
                _counter = v.toInt();
              });
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _ignite, child: const Text('Ignite')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: _abort, child: const Text('Abort')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: _reset, child: const Text('Reset')),
            ],
          ),
        ],
      ),
    );
  }
}
