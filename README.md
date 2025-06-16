# Plant Health iOS App

This example project demonstrates a simple SwiftUI application that uses the camera to capture a photo of a plant and attempts to determine the plant's condition using a Core ML model.

## Project Structure

- `PlantHealthApp.swift` – Entry point for the SwiftUI app.
- `ContentView.swift` – Main user interface, displays the camera button, the captured image, and classification results.
- `ImagePicker.swift` – A `UIViewControllerRepresentable` wrapper for `UIImagePickerController` to use the camera within SwiftUI.
- `PlantAnalyzer.swift` – Handles loading the Core ML model and running image classification using the Vision framework.

## Core ML Model

The app expects a compiled Core ML model named `PlantConditionClassifier.mlmodelc` to be included in the app bundle. This model should output text classifications describing plant conditions (for example: *needs water*, *over watered*, *nutrient deficiency*, etc.).

You can create or download a suitable model and add it to the Xcode project. After adding the `.mlmodel` file, Xcode automatically compiles it into `.mlmodelc` for use at runtime.

## Usage

1. Open the `PlantHealth` directory in Xcode.
2. Add your `PlantConditionClassifier.mlmodel` file to the project.
3. Build and run the app on a device (camera access is required).
4. Tap **Take Photo** to capture an image of the plant. The app will attempt to classify its condition and display the result.

This project is a minimal starting point. You can expand it with improved UI, additional error handling, and a more advanced Core ML model for better accuracy.
