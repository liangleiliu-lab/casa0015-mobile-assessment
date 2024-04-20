import 'dart:io';
import 'package:google_speech/google_speech.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart';

class AudioRecognize {
  final String fileName;
  String text = '';

  AudioRecognize(this.fileName) {
    recognize();
  }

  Future<String> recognize() async {
    final serviceAccount = ServiceAccount.fromString(
        (await rootBundle.loadString('assets/steam-bonbon-405017-71087f840f78.json')));
    final speechToText = SpeechToTextBeta.viaServiceAccount(serviceAccount);
    final config = _getConfig();
    final audio = await _getAudioContent(fileName);

    await speechToText.recognize(config, audio).then((value) {
      text = value.results
          .map((e) => e.alternatives.first.transcript)
          .join('\n');
    });

    return text;
  }

 RecognitionConfigBeta _getConfig() => RecognitionConfigBeta(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: 'en-US',
      alternativeLanguageCodes: ['en-UK']);
  
   Future<List<int>> _getAudioContent(String name) async {
    
    return File(name).readAsBytesSync().toList();
  }
}