import 'package:flutter/material.dart';
import 'package:lll0015assessment/provider/recorder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/audio.dart';
import 'result.dart';
//const String recordTask = "recordTask";

class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useStreamController<List<int>>();
    final spots = useState<List<int>>([]);
    useOnAppLifecycleStateChange((beforeState, currState) {
      if (currState == AppLifecycleState.resumed) {
        ref.read(recoderProvider).record(controller);
      } else if (currState == AppLifecycleState.paused) {
        ref.read(recoderProvider).stopRecorder();
      }
    });
    useEffect(
      () {
        ref
            .read(recoderProvider)
            .init()
            .then((value) => ref.read(recoderProvider).record(controller));
        final subscription = controller.stream.listen((event) {
          final buffer = event.toList();
          spots.value = buffer;
        });
        return subscription.cancel;
      },
      [],
    );
    return Scaffold(
      body: Column(
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