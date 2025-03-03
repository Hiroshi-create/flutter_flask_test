import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final soundFileProcessingProvider = ChangeNotifierProvider((ref) => SoundFileProcessingModel());

class SoundFileProcessingModel extends ChangeNotifier {
  // AudioPlayerインスタンスを作成
  final AudioPlayer audioPlayer = AudioPlayer();

  // wavファイルのパス
  String wavFilePath = '/Users/tanakahiroshi/Desktop/flutter_flask_test/sound_file/sound_1_bpm160.wav';

  // 音声の長さ（秒）
  double duration = 0.0;

  // 音声の再生位置（秒）
  double position = 0.0;

  // 音声の再生状態
  bool isPlaying = false;

  // 音声ファイルを読み込むメソッド
  Future<void> loadSoundFile() async {
    // wavファイルが存在するかチェック
    await audioPlayer.setSource(AssetSource(wavFilePath));





    // try {
    //   if(await File(wavFilePath).exists()) {
    //     // wavファイルをアプリのキャッシュディレクトリにコピー
    //     final directory = await getTemporaryDirectory();
    //     final cachePath = '${directory.path}/sound.wav';
    //     await File(wavFilePath).copy(cachePath);

    //     // コピーしたwavファイルをAudioPlayerにセット
    //     await audioPlayer.play(DeviceFileSource(cachePath));

    //     // 音声の長さを取得
    //     duration = num.parse((await audioPlayer.getDuration() ?? 0).toString()) / 1000.0;

    //     // 音声の再生位置を監視するリスナーを登録
    //     audioPlayer.onPositionChanged.listen((event) {
    //       position = event.inSeconds.toDouble();
    //       notifyListeners();
    //     });

    //     // 音声の再生終了を監視するリスナーを登録
    //     audioPlayer.onPlayerComplete.listen((event) {
    //       isPlaying = false;
    //       position = 0.0;
    //       notifyListeners();
    //     });
    //   } else {
    //     print('wavファイルが見つかりませんでした。');
    //   }
    // } catch(e) {
    //   print("err: " + e.toString());
    // }
    
  }

  // 音声を再生するメソッド
  Future<void> playSound() async {
    if (!isPlaying) {
      await audioPlayer.play(DeviceFileSource(wavFilePath));
      isPlaying = true;
    }
  }

  // 音声を停止するメソッド
  Future<void> stopSound() async {
    if (isPlaying) {
      await audioPlayer.stop();
      isPlaying = false;
    }
  }

  // 音声の再生位置を変更するメソッド
  Future<void> seekSound(double value) async {
    await audioPlayer.seek(Duration(seconds: value.toInt()));
    position = value;
    notifyListeners();
  }
}
