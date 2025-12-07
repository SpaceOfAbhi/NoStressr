import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:vibration/vibration.dart';

class OnOffButton extends StatefulWidget {
  const OnOffButton({super.key});

  @override
  State<OnOffButton> createState() => _OnOffButtonState();
}

class _OnOffButtonState extends State<OnOffButton> {
  SMITrigger? _triggerA;
  SMITrigger? _triggerB;

  final AudioPlayer _player = AudioPlayer();

  void _onRiveInit(Artboard artboard) {
    // State Machine 1 → Animation A
    final controllerA = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    if (controllerA != null) {
      artboard.addController(controllerA);
      _triggerA = controllerA.findSMI<SMITrigger>('Pressed');
    }

    // State Machine 2 → Animation B
    final controllerB = StateMachineController.fromArtboard(
      artboard,
      'State Machine 2',
    );
    if (controllerB != null) {
      artboard.addController(controllerB);
      _triggerB = controllerB.findSMI<SMITrigger>('Pressed2');
    }
  }

  // Sound A
  Future<void> _playSoundA() async {
    final player = AudioPlayer(playerId: DateTime.now().toString());
    player.setPlayerMode(PlayerMode.lowLatency);
    await player.play(AssetSource('sounds/slideOFF.mp3'));
  }

  // Sound B
  Future<void> _playSoundB() async {
    final player = AudioPlayer(playerId: DateTime.now().toString());
    player.setPlayerMode(PlayerMode.lowLatency);
    await player.play(AssetSource('sounds/slideON.mp3'));
  }

  // Example: single tap cycles animation A -> B
  bool toggle = true;
  void _onTap() async {
    if (toggle) {
      _triggerA?.fire();
      _playSoundA();
    } else {
      _triggerB?.fire();
      _playSoundB();
    }

    toggle = !toggle;

    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 18, 23),
      body: Center(
        child: GestureDetector(
          onTap: _onTap,
          child: Align(
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: 90 * 3.1415926535 / 180,
              child: RiveAnimation.asset(
                'assets/rive/7746-14925-switch-button.riv',
                onInit: _onRiveInit,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
