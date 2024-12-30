import 'package:flutter_3d_objects/flutter_3d_objects.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3D Scene with Flutter Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late Scene _scene;
  double x = 0;
  double y = 3;
  double z = 8;
  late AnimationController _controller;
  late Animation<double> _animation;
  Object? _p;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    scene.camera.position.z = z;
    scene.camera.position.y = y;
    scene.camera.position.x = x;
    _p = Object(
      position: Vector3(0, -2.5, 0),
      scale: Vector3(4, 4, 4),
      fileName: 'assets/p.obj',
      children: [
        Object(
          fileName: 'assets/c.obj',
          position: Vector3(0.25, 0.15, -0.24),
          scale: Vector3(0.8, 0.8, 0.8),
        ),
        Object(
          fileName: 'assets/d.obj',
          position: Vector3(-0.3, 0.1, 0.2),
          scale: Vector3(0.6, 0.6, 0.6),
        ),
        Object(
          fileName: 'assets/e.obj',
          position: Vector3(0.0, 0.3, -0.3),
          scale: Vector3(0.7, 0.7, 0.7),
        ),
      ],
    );
    scene.world.add(_p!);
  }

  void rotateLeft() {
    _animateRotation(90);
  }

  void rotateRight() {
    _animateRotation(-90);
  }

  void _animateRotation(double angle) {
    final double begin = _p!.rotation.y;
    final double end = _p!.rotation.y + angle;

    _animation = Tween<double>(begin: begin, end: end).animate(_controller)
      ..addListener(() {
        setState(() {
          _p!.rotation.y = _animation.value;
          _p!.updateTransform();
          _scene.update();
        });
      });

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Object Viewer'),
      ),
      body: Stack(
        children: [
          Cube(
            interactive: false,
            zoom: false,
            onSceneCreated: _onSceneCreated,
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: rotateLeft,
                  child: const Text('Rotate Left'),
                ),
                ElevatedButton(
                  onPressed: rotateRight,
                  child: const Text('Rotate Right'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
