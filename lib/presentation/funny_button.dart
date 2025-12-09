import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:vibration/vibration.dart';

class FunnyButton extends StatefulWidget {
  const FunnyButton({super.key});

  @override
  State<FunnyButton> createState() => _FunnyButtonState();
}

class _FunnyButtonState extends State<FunnyButton> {
  SMITrigger? _triggerA;

  void _onRiveInit(Artboard artboard) {
    final controllerA = StateMachineController.fromArtboard(
      artboard,
      'Motion', // Updated for your new Rive state machine
    );
    if (controllerA != null) {
      artboard.addController(controllerA);
      _triggerA = controllerA.findSMI<SMITrigger>(
        'isPressed',
      ); // Updated input name
    }
  }

  Future<void> _playSound() async {
    final player = AudioPlayer(playerId: DateTime.now().toString());
    player.setPlayerMode(PlayerMode.lowLatency);
    await player.play(AssetSource('sounds/jellybounce.mp3'));
  }

  void _onTap() async {
    _triggerA?.fire();
    _playSound();

    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: _onTap,
          child: RiveAnimation.asset(
            'assets/rive/3695-7723-funny-buttom.riv',
            onInit: _onRiveInit,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
