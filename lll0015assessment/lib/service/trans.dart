import 'dart:io';
import 'package:googleapis/speech/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

Future<String> transcribeAudio(String filePath, String apiKey) async {
  final bytes = await File(filePath).readAsBytes();

  final client = await clientViaApiKey(apiKey);
  final speechApi = SpeechApi(client);

  final config = RecognitionConfig(
    encoding: 'LINEAR16',
    sampleRateHertz: 16000,
    languageCode: 'en-US',
  );
  final audio = RecognitionAudio(content: bytes);

  final request = SyncRecognizeRequest(config: config, audio: audio);
  final response = await speechApi.speech.syncrecognize(request);

  client.close();

  if (response.results != null && response.results!.isNotEmpty) {
    return response.results!.first.alternatives!.first.transcript!;
  } else {
    return 'No transcription available';
  }
}