import 'package:flutter/material.dart';
import 'package:lll0015assessment/provider/recorder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newton_particles/newton_particles.dart';
import '../provider/audio.dart';
import 'result.dart';

class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useStreamController<List<int>>();
    final spots = useState<List<int>>([]);
     final newtonActive = useState<bool>(false);
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
            });
        final subscription = controller.stream.listen((event) {
          final buffer = event.toList();
          spots.value = buffer;
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
          Newton(
            activeEffects: [
              RainEffect(
                particleConfiguration: ParticleConfiguration(
                  shape: CircleShape(),
                  size: const Size(5, 5),
                  color: const SingleParticleColor(color: Colors.black),
                ),
                effectConfiguration: const EffectConfiguration(),
              ),
            ],
          ),
          Column(
            children: [
              // Waveform(audioData: spots.value),
              ElevatedButton(
                onPressed: () async {
                  // await ref.read(audioServiceProvider).play();
                  ref.read(recoderProvider).vad.resetState();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListFilesPage()),
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