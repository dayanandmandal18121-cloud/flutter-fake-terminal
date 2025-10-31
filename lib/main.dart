import 'package:flutter/material.dart';

void main() {
  runApp(const FakeTerminalApp());
}
// Edited for GitHub Actions
class FakeTerminalApp extends StatelessWidget {
  const FakeTerminalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FakeTerminalScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FakeTerminalScreen extends StatefulWidget {
  @override
  _FakeTerminalScreenState createState() => _FakeTerminalScreenState();
}

class _FakeTerminalScreenState extends State<FakeTerminalScreen> {
  final List<String> _output = ['Welcome to Fake Terminal!'];
  final TextEditingController _controller = TextEditingController();

  void _onCommandSubmitted(String command) {
    setState(() {
      _output.add('> $command');
      // Fake command response:
      if (command.toLowerCase() == 'help') {
        _output.add('Available commands:
help, clear, exit');
      } else if (command.toLowerCase() == 'clear') {
        _output.clear();
      } else if (command.toLowerCase() == 'exit') {
        _output.add('Exiting...');
      } else {
        _output.add('Unknown command: $command');
      }
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: _output
                    .map((line) => Text(
                          line,
                          style: TextStyle(color: Colors.green, fontFamily: 'monospace'),
                        ))
                    .toList(),
              ),
            ),
            Row(
              children: [
                Text('> ', style: TextStyle(color: Colors.green, fontFamily: 'monospace')),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.green, fontFamily: 'monospace'),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a command...',
                      hintStyle: TextStyle(color: Colors.green[200]),
                    ),
                    onSubmitted: _onCommandSubmitted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
