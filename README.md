# SparkJoy – Rate Experience App

A delightful Flutter experience rating screen with expressive animations, smooth color transitions, and an interactive slider. Built to be easy to drop into any app.

## Features

- Smooth, physics-inspired slider with snap-to-states
- Expressive animated face driven by a single percentage value
- Color interpolation across Bad → Not Bad → Good
- Clean architecture with small, testable widgets
- Responsive layout via `flutter_screenutil` (iPhone 14/15 base design)
- Centralized constants for spacing, durations, and strings

## Demo

- Drag the handle to change the mood
- Tap “Add notes” to write a note, “Submit” to see a thank-you screen

## Getting Started

1) Prerequisites
- Flutter 3.16+ recommended

2) Install
```bash
git clone <your-repo-url>
cd sparkjoy
flutter pub get
```

3) Run
```bash
flutter run
```

## How to Use in Your App

- Copy the `lib/` folder or specific widgets/screens you need
- Ensure `flutter_screenutil` is in your `pubspec.yaml`
- Set your design size in `main.dart` using `ScreenUtilInit`
- Customize constants in `lib/utils/constants.dart`

Key files:
- `lib/screens/rate_experience_screen.dart`: Main screen
- `lib/widgets/experience_slider.dart`: Custom slider with snapping
- `lib/widgets/animated_face.dart`: Face with eyes/mouth animation
- `lib/widgets/animated_text_display.dart`: Headline word transitions
- `lib/widgets/action_buttons.dart`: Bottom actions
- `lib/widgets/note_input_view.dart`: Notes input area
- `lib/widgets/submit_button.dart`: Shared Submit button
- `lib/models/experience.dart`: Enum with colors, labels, and helpers
- `lib/utils/constants.dart`: Spacing, durations, strings

## Configuration

- Design base: iPhone 14/15 logical size `Size(393, 852)` in `main.dart`
- Adjust spacing, radii, durations, and strings in `constants.dart`
- Colors live in `Experience` enum; interpolation via `Experience.colorsFor(percentage)`

## Contributing

PRs and issues welcome! Please keep code readable and follow existing styles.

## License

This project is licensed under the MIT License – see `LICENSE`.

Copyright (c) 2025 Ionic Errrrs Code