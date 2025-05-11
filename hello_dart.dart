import 'dart:io';
import 'dart:math' as math;

// Main function - entry point for every Dart program
void main() {
  print('Hejsan, Dart världen!');
  // Variables
  var name = 'Dart Programmer';
  String greeting = 'Welcome';
  int answer = 42;
  double pi = 3.14159;
  bool isAwesome = true;
  // String interpolation
  print('$greeting, $name! The answer is $answer and π is approximately $pi');
  // Lists
  List<String> fruits = ['apple', 'banana', 'orange'];
  print('Fruits: $fruits');
  print('==============');
  for (var fruit in fruits) {
    print('- $fruit');
  }
  // Maps (dictionaries)
  Map<String, dynamic> person = {
    'name': 'John Doe',
    'age': 30,
    'isEmployed': true,
  };
  print('\nPerson details:');
  person.forEach(action: (key, value) {
    print('$key: $value');
  });
  // Calling a function
  print('\n${calculateArea(5.0)}');
  // Using a class
  var circle = Circle(3.0);
  print('Circle with radius ${circle.radius} has area: ${circle.area()}');
  // Async function
  print('\nStarting countdown...');
  countDown(3);
}
// Function with return type
String calculateArea(double radius) {
  double area = math.pi * radius * radius;
  return 'A circle with radius $radius has an area of ${area.toStringAsFixed(2)}';
}
// Class definition
class Circle {
  final double radius;
  // Constructor
  Circle({required this.radius});
  // Method
  double area() {
    return math.pi * radius * radius
  }
}
// Async function
void countDown(int seconds) {
  for (int i = seconds; i>0; i--) {
    print('$i...');
    sleep(Duration(seconds: 1)); // Not recomended in real apps, just for demo
  }
  print('Done!');
}