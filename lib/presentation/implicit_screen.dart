import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({super.key});

  @override
  _ImplicitAnimationScreenState createState() => _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool isExpanded = false;
  bool isRotated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Implicit Animation Demo'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Touch the box',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),

            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  isRotated = !isRotated;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceOut,
                width: isExpanded ? 200 : 100,
                height: isExpanded ? 200 : 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isExpanded
                        ? [Colors.purple, Colors.blue]
                        : [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(isExpanded ? 50 : 10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: isExpanded ? 15 : 5,
                      offset: Offset(0, isExpanded ? 8 : 3),
                    )
                  ],
                ),
                child: AnimatedRotation(
                  duration: Duration(milliseconds: 500),
                  turns: isRotated ? 0.25 : 0,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 300),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isExpanded ? 24 : 16,
                      ),
                      child: Text('Magic!'),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: isExpanded ? 1.0 : 0.7,
              child: Text(
                isExpanded ? '🎉 Expanded!' : '📦 Collapsed',
                style: TextStyle(
                  fontSize: 16,
                  color: isExpanded ? Colors.purple : Colors.grey[600],
                ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Size, Color, Radius, Shadow, Rotation is animated!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ),

      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
              isRotated = !isRotated;
            });
          },
          backgroundColor: isExpanded ? Colors.purple : Colors.orange,
          child: AnimatedRotation(
            duration: Duration(milliseconds: 500),
            turns: isRotated ? 1 : 0,
            child: Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}
