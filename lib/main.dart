import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const channelName = 'com.example.module-test/custom';
const methodChannel = MethodChannel(channelName);

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Module Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/custom1': (context) => const Custom1(title: 'Flutter Custom Module1'),
      },
    );
  }
}
class Custom1 extends StatefulWidget {
  const Custom1({super.key, required this.title});
  final String title;

  @override
  State<Custom1> createState() => _Custom1State();
}

class _Custom1State extends State<Custom1> {
  int _counter = 0;
  var _methodCallArguments = "null";

  @override
  void initState() {
    super.initState();
    print("new_feature_flutter loaded");
    // 화면이 생성되는 순간 메소드 채널에서 호출되는 메소드의 핸들러를 설정
    methodChannel.setMethodCallHandler(methodHandler);
  }

  Future<dynamic> methodHandler(MethodCall methodCall) async {
    print('methodHandler: ${methodCall.method}');
    if (methodCall.method == "getUserToken"){
      // 메소드 채널에서 호출된 메소드가 "getUserToken"이라는 메소드인 경우
      print('methodHandler: ${methodCall.arguments}');
      setState(() {
        _methodCallArguments = methodCall.arguments;
      }); // "getUserToken"이라는 메소드를 통해 들어온 인자를 private 변수에 저장
      return "received flutter";
    }
  } // 메소드 채널로 전달된 인자를 private 변수로 저장합니다

  void _incrementCounter() {
    setState(() {
      _counter++;
      print("_methodCallArguments: $_methodCallArguments");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            SystemNavigator.pop();
          },
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Module Test1',
            ),
            Text(
              '$_counter',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  const Text(
                      "Method Call Arguments"
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _methodCallArguments,
                    ),
                  ), // 메소드 채널로 받은 인자를 화면에 출력합니다
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
