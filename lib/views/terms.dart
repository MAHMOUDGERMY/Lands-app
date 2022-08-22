import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms and conditions")),
      body: const Center(
        child: Text("Terms and conditions"),
      ),
    );
  }
}
