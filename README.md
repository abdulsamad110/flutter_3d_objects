## **[Flutter 3D Objects]**

[![pub package](https://img.shields.io/badge/pub-v1.0.1+1-blue)](https://pub.dev/packages/paginate_firestore_plus)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

This package allows Flutter developers to easily display 3D models in their applications. It supports the `.obj` file format and provides functionalities to manipulate the scene, including setting camera positions and adding objects with child objects.

**Features:**

- Display 3D models from `.obj` files
- Add and manipulate objects within the scene
- Set camera positions to adjust the view
- Support for hierarchical object structures

## Setup

**How to use this**

- Add dependency in pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
flutter_3d_objects:
```

- Add 3D Models in assets, file type should be .obj

```yaml
flutter:
assets:
  - assets/p.obj
  - assets/c.obj
```

## Usage

```dart
void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Cube(
            onSceneCreated: (Scene scene) {
              scene.world.add(
                Object(
                  fileName: 'assets/c.obj',
                  position: Vector3(1, 1, 1),
                  scale: Vector3(1, 1, 1),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

## Example

```dart
//Create a variable
late Scene _scene;
double x = 0;
double y = 3;
double z = 8;
late AnimationController _controller;
late Animation<double> _animation;
Object? _p;

// Create Function
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
       ]);
   scene.world.add(_p!);
 }

//Function to rotate
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

// In main widget function
Scaffold(
     appBar: AppBar(
       title: const Text(''),
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
                 child: const Text('Left'),
               ),
               ElevatedButton(
                 onPressed: rotateRight,
                 child: const Text('Right'),
               ),
             ],
           ),
         ),
       ],
     ),
   );
```
