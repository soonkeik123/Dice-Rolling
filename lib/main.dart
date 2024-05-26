import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roll',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dice Roll'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentImageIndex = 0;

  // Create a list to store all images from assets
  List<String> images = [
    'assets/images/dice-1.png',
    'assets/images/dice-2.png',
    'assets/images/dice-3.png',
    'assets/images/dice-4.png',
    'assets/images/dice-5.png',
    'assets/images/dice-6.png',
  ];
  AudioPlayer player = AudioPlayer();
  Random random = Random();

  int counter = 1; // Counting the time of dice changed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Transform.rotate(
              angle: random.nextDouble() * 180,
              child: Image.asset(
                images[currentImageIndex],
                height: 100,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () async {
                  // Rolling the dice

                  // Sound Effect
                  await player.setAsset('assets/audios/rolling-dice.mp3');
                  player.play();

                  // Set the time of randoming the dice
                  Timer.periodic(const Duration(milliseconds: 80), (timer) {
                    counter++;
                    setState(() {
                      currentImageIndex = random.nextInt(6);
                    });

                    if (counter >= 13) {
                      timer.cancel();

                      setState(() {
                        counter = 1;
                      });
                    }
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Roll',
                    style: TextStyle(fontSize: 26),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
