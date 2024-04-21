import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
      _files = files.where((file) => file.path.endsWith('.wav')).toList().reversed.toList();
    });
    _getDurations();
  }

  void _getDurations() async {
    final futures = _files.map((file) => getWavDuration(file.path));
    final durations = await Future.wait(futures);
    for (var i = 0; i < _files.length; i++) {
      _fileDurations[_files[i].path] = durations[i];
    }
    setState(() {});
  }

 Future<Duration> getWavDuration(String filePath) async {
  final file = File(filePath);
  final size = await file.length();
  final byteRate = 16000 * 16 * 1 ~/ 8;
  final duration = size / byteRate;

  return Duration(seconds: duration.round());
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
        title: Text('dreamtalks records'),
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
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.play_arrow),
                    onPressed: () => _audioPlayer.play(DeviceFileSource(file.path)),
                  ),
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