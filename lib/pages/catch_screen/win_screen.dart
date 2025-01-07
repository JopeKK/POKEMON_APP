import 'package:flutter/material.dart';


class WinScreen extends StatefulWidget {
  final String name;
  const WinScreen({
    super.key,
    required this.name,
  });

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Zdobyles go ${widget.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
