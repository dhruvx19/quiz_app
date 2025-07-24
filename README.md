# Quiz App - Flutter Firebase

A beautiful, interactive quiz application built with Flutter and Firebase, featuring smooth animations, user authentication, and real-time data storage.

## Preview

### Video Demonstrations

#### Mobile App Demo
[![Quiz App Mobile Demo](https://img.youtube.com/vi/m7yGeF6Bif4/maxresdefault.jpg)](https://youtu.be/m7yGeF6Bif4)

**Watch the complete app walkthrough**: Login, registration, quiz interface, animations, and results display.

#### Firebase Integration Demo
[![Firebase Database Demo](https://img.youtube.com/vi/2vgfZk54CA8/maxresdefault.jpg)](https://youtu.be/2vgfZk54CA8)

**See Firestore in action**: Real-time data storage, user authentication, and quiz result tracking.

### Local Demo Files
For developers who prefer local access:
- **App Demo**: [`assets/images/app_demo.mov`](assets/images/app_demo.mov)
- **Firebase Demo**: [`assets/images/firebase.mov`](assets/images/firebase.mov)


### What's Demonstrated
- **Mobile Demo**: Complete user experience from splash screen to quiz completion
- **Firebase Demo**: Backend integration, data flow, and real-time database operations
- **Key Features**: Authentication, quiz mechanics, result tracking, and data persistence

## Features

### Authentication
- **Email/Password Registration** - Create account with validation
- **Email/Password Login** - Secure user authentication  
- **Firebase Auth Integration** - Reliable authentication system
- **User Profile Management** - Store user data securely
- **Auto Login** - Remember user sessions

### Quiz System
- **Interactive Quiz Interface** - Beautiful, user-friendly design
- **Multiple Choice Questions** - Support for various question types
- **Real-time Progress Tracking** - Visual progress indicators
- **Question Navigation** - Smooth transitions between questions
- **Answer Validation** - Instant feedback on selections
- **Timer Support** - Optional time limits for quizzes

### User Experience
- **Smooth Animations** - Polished transitions and micro-interactions
- **Confetti Celebrations** - Fun animations for achievements
- **Responsive Design** - Works on all screen sizes
- **Dark/Light Themes** - Elegant visual design
- **Loading States** - Clear feedback during operations
- **Error Handling** - Graceful error messages

### Data Management
- **Firebase Firestore** - Real-time database storage
- **Quiz Results Storage** - Persistent result tracking
- **User Progress** - Track performance over time
- **Offline Support** - Local data caching
- **Data Synchronization** - Seamless cloud sync

### Results & Analytics
- **Detailed Score Display** - Comprehensive result breakdown
- **Performance Metrics** - Track improvement over time
- **Achievement System** - Celebrate milestones
- **History Tracking** - View past quiz attempts
- **Export Results** - Share achievements

## Getting Started

### Prerequisites
- **Flutter SDK** (≥ 3.0.0)
- **Dart SDK** (≥ 3.0.0)
- **Android Studio / VS Code**
- **Firebase Account**
- **iOS/Android Device or Emulator**

### Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/dhruvx19/quiz_app.git
cd quiz_app
```

#### 2. Install Dependencies
```bash
flutter pub get
```

#### 3. Firebase Setup

##### Install Firebase CLI
```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```

##### Login to Firebase
```bash
firebase login
```

##### Configure Firebase for Flutter
```bash
flutterfire configure
```

This will:
- Create a new Firebase project (or select existing)
- Configure iOS and Android apps
- Generate `firebase_options.dart`
- Set up authentication and Firestore

#### 4. iOS Setup (if running on iOS)
```bash
cd ios
pod install
cd ..
```

#### 5. Run the App
```bash
flutter run
```


### Firebase Authentication
Enable these sign-in methods in Firebase Console:
- Email/Password
- Anonymous (optional)


## Project Structure

```
lib/
├── constants/
│   ├── api_constants.dart      # API endpoints
├── models/
│   ├── user_model.dart         # User data model
│   ├── quiz_model.dart         # Quiz data model  
│   └── result_model.dart       # Result data model
├── providers/
│   ├── auth_provider.dart      # Authentication state
│   └── quiz_provider.dart      # Quiz state management
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart   # Login interface
│   │   └── register_screen.dart # Registration
│   ├── quiz/
│   │   ├── home_screen.dart    # Quiz selection
│   │   ├── quiz_screen.dart    # Quiz interface
│   │   └── result_screen.dart  # Results display
│   └── splash_screen.dart      # Splash screen
├── widgets/
│   ├── quiz_button.dart        # Custom button widget
│   ├── quiz_scaffold.dart      # Custom scaffold
│   └── gradient_text.dart      # Gradient text widget
└── main.dart                   # App entry point
```

## Database Schema

### Firestore Collections

#### Users Collection (`/users/{userId}`)
```json
{
  "uid": "user_unique_id",
  "email": "user@example.com",
  "displayName": "John Doe",
  "createdAt": "2024-01-01T00:00:00Z",
  "lastLoginAt": "2024-01-01T00:00:00Z",
  "totalQuizzes": 5,
  "averageScore": 78.5
}
```

#### Quizzes Collection (`/quizzes/{quizId}`)
```json
{
  "id": "quiz_unique_id",
  "title": "General Knowledge Quiz",
  "description": "Test your general knowledge",
  "category": "General",
  "difficulty": "medium",
  "questions": [
    {
      "id": "question_1",
      "question": "What is the capital of France?",
      "options": ["London", "Berlin", "Paris", "Madrid"],
      "correctAnswer": "Paris",
      "category": "Geography"
    }
  ],
  "createdAt": "2024-01-01T00:00:00Z",
  "isActive": true
}
```

#### Quiz Results Collection (`/quiz_results/{resultId}`)
```json
{
  "id": "result_unique_id",
  "userId": "user_unique_id",
  "quizId": "quiz_unique_id",
  "score": 8,
  "totalQuestions": 10,
  "percentage": 80,
  "answers": [
    {
      "questionId": "question_1",
      "selectedAnswer": "Paris",
      "correctAnswer": "Paris",
      "isCorrect": true
    }
  ],
  "completedAt": "2024-01-01T00:00:00Z",
  "timeTaken": 300
}
```





## Troubleshooting

### Common Issues

#### CocoaPods Issues (iOS)
```bash
cd ios
pod deintegrate
pod install
```

#### Firebase Not Initialized
```bash
flutterfire configure
flutter clean
flutter pub get
```

#### Build Errors
```bash
flutter clean
flutter pub get
flutter pub deps
flutter run
```


