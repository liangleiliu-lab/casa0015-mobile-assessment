import 'package:flutter/material.dart';
import 'package:lll0015assessment/provider/recorder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import 'package:lll0015assessment/provider/recorder.dart';
const String recordTask = "recordTask";

class RecordPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = useState(false);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(50),
          ),
          onPressed: () {
            if (isRecording.value) {
              Workmanager().cancelAll();
              ref.read(recoderProvider).stopRecorder();
            } else {
              Workmanager().registerOneOffTask("1", recordTask);
              ref.read(recoderProvider).record();
            }
            isRecording.value = !isRecording.value;
          },
          child: Text(isRecording.value ? 'Stop' : 'Start'),
        ),
      ),
    );
  }
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final RecoderProvider recoderProvider = RecoderProvider();
    switch (task) {
      case recordTask:
        recoderProvider.record();
        break;
      case Workmanager.iOSBackgroundTask:
        recoderProvider.record();
        break;
    }
    return Future.value(true);
  });
}