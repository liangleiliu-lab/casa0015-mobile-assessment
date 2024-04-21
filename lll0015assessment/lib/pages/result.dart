import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

import '../service/trans.dart';

class ListFilesPage extends StatefulWidget {
  @override
  _ListFilesPageState createState() => _ListFilesPageState();
}

class _ListFilesPageState extends State<ListFilesPage> {
  List<FileSystemEntity> _files = [];
  final Map<String, String> _recognizedTexts = {};
  final Map<String, Duration> _fileDurations = {};
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _getWavFiles();
  }

  Future<void> _getWavFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync();
    setState(() {
      _files = files.where((file) => file.path.endsWith('.wav')).toList();
    });
    _files.forEach((file) async {
      final duration = await _getAudioDuration(file.path);
      setState(() {
        _fileDurations[file.path] = duration!;
      });
    });
  }

  Future<Duration?> _getAudioDuration(String path) async {
    final durationInMilliseconds = await _audioPlayer.getDuration();
    return durationInMilliseconds;
  }

  Future<void> _recognizeAudio(FileSystemEntity file) async {
    final audioRecognize = AudioRecognize(file.path);
    final text = await audioRecognize.recognize();
    setState(() {
      _recognizedTexts[file.path] = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of .wav Files'),
      ),
      body: ListView.builder(
        itemCount: _files.length,
        itemBuilder: (context, index) {
          final file = _files[index];
          final fileName = file.path.split('/').last;
          return ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => _audioPlayer.play(DeviceFileSource(file.path)),
                ),
                Text('${_fileDurations[file.path]?.inSeconds ?? 0} sec'),
              ],
            ),
            title: Text(fileName),
            subtitle: Text('${_recognizedTexts[file.path] ?? ''}'),
            onTap: () => _recognizeAudio(file),
          );
        },
      ),
    );
  }
}