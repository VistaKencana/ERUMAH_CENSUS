import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: const Text('Coming Soon'),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.25),
              const Icon(
                Icons.construction_rounded,
                size: 60,
              ),
              const Text(
                'Coming Soon',
                style: TextStyle(fontSize: 25),
              ),
              const Text(
                'New screen in the works. Coming your way soon!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
