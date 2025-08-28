<<<<<<< HEAD
# tisserproject

A new Flutter project.

## Getting Started

 Libraries & Tools Used

 

Flutter (UI framework)

Firebase Core – app initialization

Cloud Firestore – database & offline caching

Bloc / Provider – state management (depending on your setup)

Google Fonts / Lottie (optional, for UI polish)

 Trade-offs & Assumptions
 

Firestore’s built-in offline persistence handles caching → no custom caching layer was added.

Basic error handling (network, empty data) is included; more advanced retry logic can be added later.

UI is designed to be clean and responsive, but not fully production-styled.

State management was chosen (Bloc/Provider) for clarity and scalability — simpler than setState, but more structure.

 Evaluation Criteria
1. Functionality

Fetches and displays data from Firestore.

Works offline using Firestore caching.

Updates automatically when network is back.

2. Code Quality

Clean, modular structure with separation of UI and logic.

Easy to extend with new features.

3. UI/UX

Responsive design (adapts to device sizes).

Simple and intuitive navigation.

Uses Material design widgets + custom styling.

4. State Management

Proper separation of concerns (UI vs business logic).

Consistent state updates with Bloc/Provider.

5. Error Handling & Offline Support

Shows fallback UI when data is not available.

Offline persistence enabled (Firestore default).

Network errors handled gracefully.

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# machine_testproject
>>>>>>> 43ce3069dbb4872faa8542eeeb12429f02b9cff1
