import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_feature_flutter_module/presentation/hero_screen.dart';
import 'package:new_feature_flutter_module/presentation/weather_screen.dart';

import 'models/userInfo.dart';

// Androidと同じMethodChannel名を使用
const channelName = 'com.example.new_feature_android/custom1';
const methodChannel = MethodChannel(channelName);

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Module Test',
      theme: ThemeData(primarySwatch: Colors.blue),
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
  List<UserInfo> _userList = [];
  UserInfo? _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print("new flutter loaded");
    _loadUserData();
  }

  // Request User data to Android
  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      // getUserInfo メソット呼び出し
      final result = await methodChannel.invokeMethod('getUserInfo');
      if (result is List) {
        setState(() {
          _userList = result
              .map(
                (userMap) =>
                    UserInfo.fromMap(Map<String, dynamic>.from(userMap)),
              )
              .toList();
        });
      }

      final currentUserResult = await methodChannel.invokeMethod(
        'getCurrentUser',
      );
      if (currentUserResult is Map) {
        setState(() {
          _currentUser = UserInfo.fromMap(
            Map<String, dynamic>.from(currentUserResult),
          );
        });
      }

      print('Loaded ${_userList.length} users');
      print('Current user: ${_currentUser?.name}');
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Module Test1',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Counter: $_counter',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 32),

                  if (_currentUser != null) ...[
                    const Text(
                      'Current User:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: _currentUser!.profilePictureUrl != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  _currentUser!.profilePictureUrl!,
                                ),
                              )
                            : const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(_currentUser!.name),
                        subtitle: Text(_currentUser!.email),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  const Text(
                    'All Users:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _userList.length,
                    itemBuilder: (context, index) {
                      final user = _userList[index];
                      return Card(
                        child: ListTile(
                          leading: user.profilePictureUrl != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    user.profilePictureUrl!,
                                  ),
                                )
                              : const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: Text('ID: ${user.id}'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroAnimationScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.flight_takeoff,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Hero Animation Demo',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.flight_takeoff,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Async Weather Demo',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
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
