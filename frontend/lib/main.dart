// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_grpc/dart_pb/greet.pb.dart' as greet_pb;
import 'package:flutter_grpc/dart_pb/greet.pbgrpc.dart' as greet_pbgrpc;
import 'package:flutter_grpc/pages/daw_page.dart';
import 'package:grpc/grpc.dart';

void main(List<String> args) async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // アプリケーションの向きを横画面に設定
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('gRPC Demo')),
        body: const Center(child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // gRPC client stub
  late greet_pbgrpc.GreeterClient stub;

  // Text controller for the input field
  final TextEditingController _controller = TextEditingController();

  // Text for the result display
  String _result = '';

  @override
  void initState() {
    super.initState();
    // gRPC チャネルとスタブを作成
    final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = greet_pbgrpc.GreeterClient(channel);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              child: const Text('DAW'),
              onPressed: () {
              // ボタンが押されたら、新しいページに遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoundFileProcessingUI()),
              );
            },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter name(s)',
                hintText: 'e.g. Alice, Bob, Charlie',
              ),
            ),
          ),
          _createButtonColumn([
            _createButton('SayHello', _sayHello),
            _createButton('ParrotSaysHello', _parrotSaysHello),
            _createButton('ChattyClientSaysHello', _chattyClientSaysHello),
            _createButton('InteractingHello', _interactingHello),
          ]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _result,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      )
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // 単項 RPC 呼び出しを処理するメソッド
  void _sayHello() async {
    try {
      // 入力フィールドから名前を取得
      final name = _controller.text;
      if (name.isEmpty) {
        _showSnackbar('Please enter a name');
        return;
      }
      // 次の名前でリクエスト オブジェクトを作成
      final request = greet_pb.HelloRequest()
        ..greeting = 'Bonjour'
        ..name = name;
      // rpcメソッドを呼び出して応答を待つ
      final response = await stub.sayHello(request);
      // 結果テキストを応答メッセージで更新
      setState(() {
        _result = response.message;
      });
    } catch (e) {
      _showSnackbar('Something went wrong: $e');
    }
  }

  // サーバーストリーミング RPC 呼び出しを処理するメソッド
  void _parrotSaysHello() async {
    try {
      // 入力フィールドから名前を取得
      final name = _controller.text;
      if (name.isEmpty) {
        _showSnackbar('Please enter a name');
        return;
      }
      // 次の名前でリクエスト オブジェクトを作成
      final request = greet_pb.HelloRequest()
        ..greeting = 'Bonjour'
        ..name = name;
      // rpc メソッドを呼び出して応答のストリームを取得
      final responses = stub.parrotSaysHello(request);
      // ストリームをlistenし、各応答メッセージで結果テキストを更新
      responses.listen((response) {
        setState(() {
          _result += '\n${response.message}\n';
        });
      }).onError((e) {
        _showSnackbar('Something went wrong: $e');
      });
    } catch (e) {
      _showSnackbar('Something went wrong: $e');
    }
  }

  // クライアントのストリーミング RPC 呼び出しを処理
  void _chattyClientSaysHello() async {
    try {
      // 入力フィールドからカンマで区切られた名前を取得
      final names = _controller.text.split(',');
      if (names.isEmpty || names.any((name) => name.isEmpty)) {
        _showSnackbar('Please enter one or more names, separated by commas');
        return;
      }
      // 次の名前を使用してリクエスト オブジェクトのストリームを作成
      final requests = Stream.fromIterable(names.map((name) {
        return greet_pb.HelloRequest()
          ..greeting = 'Hello'
          ..name = name;
      }));
      // リクエストのストリームで rpc メソッドを呼び出し、レスポンスを待つ
      final response = await stub.chattyClientSaysHello(requests);
      // 結果テキストを応答メッセージで更新
      setState(() {
        _result = response.message;
      });
    } catch (e) {
      _showSnackbar('Something went wrong: $e');
    }
  }

  // 双方向ストリーミング RPC 呼び出しを処理するメソッド
  void _interactingHello() async {
    try {
      // 入力フィールドからカンマで区切られた名前を取得
      final names = _controller.text.split(',');
      if (names.isEmpty || names.any((name) => name.isEmpty)) {
        _showSnackbar('Please enter one or more names, separated by commas');
        return;
      }
      // 次の名前を使用してリクエスト オブジェクトのストリームを作成
      final requests = Stream.fromIterable(names.map((name) {
        return greet_pb.HelloRequest()
          ..greeting = 'Hello'
          ..name = name;
      }));
      // リクエストのストリームで rpc メソッドを呼び出し、レスポンスのストリームを取得
      final responses = stub.interactingHello(requests);
      // ストリームをlistenし、各応答メッセージで結果テキストを更新
      responses.listen((response) {
        setState(() {
          _result += '${response.message}\n';
        });
      }).onError((e) {
        _showSnackbar('Something went wrong: $e');
      });
    } catch (e) {
      _showSnackbar('Something went wrong: $e');
    }
  }

  Widget _createButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      child: Text(label),
      onPressed: onPressed,
    );
  }

  Widget _createButtonColumn(List<Widget> buttons) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }
}