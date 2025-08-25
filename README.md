# Rate Experience App 🎭

A beautiful, responsive rating experience animation built with Flutter that mimics the Jetpack Compose version with smooth animations and gesture controls.

## Features ✨

- **Smooth Animations**: Fluid transitions between different rating states
- **Interactive Slider**: Drag to change the rating with real-time visual feedback
- **Dynamic Face**: Eyes and mouth that change shape, size, and rotation
- **Color Transitions**: Beautiful color blending between rating states
- **Responsive Design**: Works perfectly on all screen sizes
- **Performance Optimized**: Smooth 60fps animations with no lag

## How It Works 🔧

The app uses a single slider position (0.0 to 1.0) to control all animations:

- **0.0 - 0.5**: Bad to Not Bad transition
- **0.5 - 1.0**: Not Bad to Good transition

As you drag the slider:
- Background color smoothly transitions
- Face expressions change dynamically
- Text labels slide in/out from the sides
- All colors blend seamlessly using linear interpolation

## Getting Started 🚀

1. **Prerequisites**
   - Flutter SDK (3.0.0 or higher)
   - Dart SDK
   - Android Studio / VS Code with Flutter extensions

2. **Installation**
   ```bash
   git clone <repository-url>
   cd rate_experience_app
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

## Architecture 🏗️

- **`main.dart`**: App entry point
- **`models/experience.dart`**: Experience enum with colors and properties
- **`widgets/mouth_painter.dart`**: Custom painter for the mouth
- **`widgets/eye_widget.dart`**: Eye widget with dynamic shapes
- **`widgets/experience_slider.dart`**: Interactive slider with gesture handling
- **`screens/rate_experience_screen.dart`**: Main screen orchestrating all animations

## Performance Features ⚡

- **Efficient Rendering**: Only rebuilds necessary widgets
- **Smooth Animations**: Uses Flutter's optimized animation system
- **Gesture Handling**: Responsive touch controls with proper gesture detection
- **Memory Management**: Proper disposal of animation controllers

## Customization 🎨

You can easily customize:
- Colors for each rating state
- Animation durations and curves
- Text styles and positioning
- Slider appearance and behavior

## Platform Support 📱

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Desktop

## Dependencies 📦

- `flutter`: Core Flutter framework
- `cupertino_icons`: iOS-style icons

## License 📄

This project is open source and available under the MIT License.