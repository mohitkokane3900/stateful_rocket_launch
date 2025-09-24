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
  bool _justShowedDialog = false;

  void _updateCounter(int next) {
    final clamped = next.clamp(0, 100);
    setState(() {
      _counter = clamped;
    });
    if (_counter == 100 && !_justShowedDialog) {
      _justShowedDialog = true;
      _showLiftoffDialog();
    }
    if (_counter < 100) {
      _justShowedDialog = false;
    }
  }

  void _ignite() => _updateCounter(_counter + 1);
  void _abort() => _updateCounter(_counter - 1);
  void _reset() => _updateCounter(0);

  Color _numberColor() {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.orange;
  }

  Future<void> _showLiftoffDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('🚀 LIFTOFF!'),
          content: const Text('Fuel at 100. Mission accomplished.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final liftoff = _counter == 100;
    return Scaffold(
      appBar: AppBar(title: const Text('Rocket Launch Controller')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mission Control', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 6),
            LinearProgressIndicator(value: _counter / 100),
            const SizedBox(height: 24),
            Row(
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
              ],
            ),
            const SizedBox(height: 8),
            if (liftoff)
              const Text(
                'LIFTOFF!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 24),
            Slider(
              min: 0,
              max: 100,
              divisions: 100,
              value: _counter.toDouble(),
              onChanged: (v) => _updateCounter(v.toInt()),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _counter < 100 ? _ignite : null,
                  child: const Text('Ignite +1'),
                ),
                ElevatedButton(
                  onPressed: _counter > 0 ? _abort : null,
                  child: const Text('Abort -1'),
                ),
                OutlinedButton(
                  onPressed: _counter != 0 ? _reset : null,
                  child: const Text('Reset 0'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
