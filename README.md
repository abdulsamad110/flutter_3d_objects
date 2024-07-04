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
  - assets/pallet.obj
  - assets/carton.obj
  ```
 
 ## Usage
  ``` dart
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
                    fileName: 'assets/carton.obj',
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
