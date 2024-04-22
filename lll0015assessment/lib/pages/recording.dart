import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lll0015assessment/provider/recorder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newton_particles/newton_particles.dart';
import 'package:path_provider/path_provider.dart';
import '../provider/audio.dart';
import 'result.dart';
import 'package:slide_countdown/slide_countdown.dart';
class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useStreamController<List<int>>();
    final spots = useState<List<int>>([]);
    final newtonActive = useState<bool>(false);
    final startTime = useState<DateTime>(DateTime.now()); 
    final sleepEventsCount = useState<int>(0);
    final previousWavFilesCount = useState<int>(0);
    // useOnAppLifecycleStateChange((beforeState, currState) {
    //   if (currState == AppLifecycleState.resumed) {
    //     ref.read(recoderProvider).record(controller);
    //   } else if (currState == AppLifecycleState.paused) {
    //     ref.read(recoderProvider).stopRecorder();
    //   }
    // });
    useEffect(
      () {
        ref
            .read(recoderProvider)
            .init()
            .then((value) {
              ref.read(recoderProvider).record(controller);
              newtonActive.value = true; 
              startTime.value = DateTime.now();
              
            });
        final subscription = controller.stream.listen((event) {
          final buffer = event.toList();
          spots.value = buffer;
        });
         getApplicationDocumentsDirectory().then((directory) {
          final files = directory.listSync();
          final wavFilesCount = files.where((file) => file.path.endsWith('.wav')).length;
          previousWavFilesCount.value = wavFilesCount;

          Timer.periodic(const Duration(seconds: 30), (timer) {
            final files = directory.listSync();
            final currentWavFilesCount = files.where((file) => file.path.endsWith('.wav')).length;
            if (currentWavFilesCount > previousWavFilesCount.value) {
              sleepEventsCount.value += currentWavFilesCount - previousWavFilesCount.value;
              previousWavFilesCount.value = currentWavFilesCount;
            }
          });
        });
        return() {
          subscription.cancel;
           ref.read(recoderProvider).stopRecorder();
           newtonActive.value = false;
          };
      },
      [],
    );
    return Scaffold(
      body: Stack(
        children: [
           Positioned.fill(
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            'assets/imgs/welcome_background.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
          Newton(
            activeEffects: [
              RainEffect(
                particleConfiguration: ParticleConfiguration(
                  shape: CircleShape(),
                  size: const Size(5, 5),
                  color: const SingleParticleColor(color: Color.fromARGB(255, 184, 163, 163)),
                ),
                effectConfiguration: const EffectConfiguration(),
              ),
            ],
          ),
          Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Waveform(audioData: spots.value),
              Text('Detected sleep events: ${sleepEventsCount.value}'),
              const Center(
                child: SlideCountdown(
                  duration: Duration(days: 2),
                  countUp: true,
                
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // await ref.read(audioServiceProvider).play();
                  ref.read(recoderProvider).vad.resetState();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListFilesPage(
                      startTime: startTime.value,
                      sleepEventsCount: sleepEventsCount.value,
                    )),
                  );
                },
                child: const Text('STOP'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     final recoderProvider recoderprovider = recoderProvider();
//     switch (task) {
//       case recordTask:
//         recoderProvider.record();
//         break;
//       case Workmanager.iOSBackgroundTask:
//         recoderProvider.record();
//         break;
//     }
//     return Future.value(true);
//   });
// }