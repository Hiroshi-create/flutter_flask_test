import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_grpc/models/sound_file_processing_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// UI関連のコードを書くためのStatefulWidgetクラスを定義
class SoundFileProcessingUI extends ConsumerWidget {
  const SoundFileProcessingUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final SoundFileProcessingModel soundFileProcessingModel = ref.watch(soundFileProcessingProvider);

    // TextEditingControllerクラスのインスタンスを作成
    TextEditingController _controller = TextEditingController();

    // SoundFileProcessingModelクラスのインスタンスを作成
    SoundFileProcessingModel soundFileProcessingModel = SoundFileProcessingModel();

    // 音声ファイルの長さと再生状態を表示するための変数を宣言
    String _duration = '';
    bool _isPlaying = false;



    // アプリケーションの向きを横画面に設定
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return WillPopScope(
      onWillPop: () async {
        // ページから戻るときに元の向きに戻す
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Flask Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // テキストフィールドを作成
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter the path of the sound file',
                ),
              ),
              // 音声ファイルの長さと再生状態を表示するテキストとアイコンを作成
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_duration),
                  Icon(
                    _isPlaying ? Icons.play_arrow : Icons.pause,
                    color: Colors.blue,
                  ),
                ],
              ),
              // 再生ボタンと停止ボタンを作成
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () async {
                      // テキストフィールドに入力された値を取得
                      // String filePath = _controller.text;
                      // 音声ファイルの長さを取得して表示
                      // Duration duration =
                      //     await audioPlayer.getDuration();
                      // await soundFileProcessingModel.playSound();
                      // _duration = soundFileProcessingModel.duration.toString();
                      // _isPlaying = true;
                      // await soundFileProcessingModel.audioPlayer.play(DeviceFileSource('/Users/tanakahiroshi/Desktop/flutter_flask_test/sound_file/sound_1_bpm160.wav'));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      // 音声ファイルの再生を停止して再生状態を更新
                      soundFileProcessingModel.stopSound();
                      _isPlaying = false;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}