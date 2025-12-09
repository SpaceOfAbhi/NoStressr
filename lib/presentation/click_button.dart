import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:vibration/vibration.dart';

class ClickButton extends StatefulWidget {
  const ClickButton({super.key});

  @override
  State<ClickButton> createState() => _ClickButtonState();
}

class _ClickButtonState extends State<ClickButton> {
  SMITrigger? _triggerA;
  SMITrigger? _triggerB;


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
    await player.play(AssetSource('sounds/button2.mp3'));
  }

  // Sound B
  Future<void> _playSoundB() async {
    final player = AudioPlayer(playerId: DateTime.now().toString());
    player.setPlayerMode(PlayerMode.lowLatency);
    await player.play(AssetSource('sounds/button1.mp3'));
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
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: _onTap,
          child: RiveAnimation.asset(
            'assets/rive/3827-8012-onoff-button.riv',
            onInit: _onRiveInit,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
