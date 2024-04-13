import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class AudioService {
  AudioService() {
    player = AudioPlayer()
      ..setAudioContext(
        const AudioContext(
          android: AudioContextAndroid(
            audioMode: AndroidAudioMode.inCommunication,
            usageType: AndroidUsageType.voiceCommunication,
          ),
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.playAndRecord,
          ),
        ),
      );
  }
  late AudioPlayer player;

  Future<void> play() async {
  final outputPath = '${(await getApplicationDocumentsDirectory()).path}/output.wav';
  final outputFile = File(outputPath);
  final path = (await getApplicationDocumentsDirectory()).path;
  await listFiles(path);
  if (await outputFile.existsSync()) {
    try {
      await player.play(DeviceFileSource(outputPath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  } else {
    print('Error: File $outputPath does not exist');
  }
}
  Future<void> listFiles(String path) async {
  final dir = Directory(path);

  if (await dir.exists()) {
    print('Files in $path:');
    await for (final entity in dir.list()) {
      if (entity is File) {
        print(entity.path);
      }
    }
  } else {
    print('Directory $path does not exist');
  }
}
}
