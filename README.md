# MJ Coffee App - Full-stack app with Flutter and Firebase Workshop

The repository is supposed to be used for the my workshops.

## Agenda

- Part 1

  - Introduction to Flutter & Dart
    - Basics of Dart (All student must be on the same page)
    - Basics of Flutter (All student must be comfortable with Flutter)
      - Stateless vs Stateful widgets
    - Show tips and tricks to speed up the development within a few minutes
  - Creating MJ Coffee app
    - Introduction to Flutter CLI
    - Scaffold the project
    - Add SVG support
    - Adding Google Fonts
    - Adding Navigator (go_router and why to use it)
    - Adding Screen
      - Homepage
        - Adding Assets
        - Adding Texts
        - Adding Buttons
        - Adding onTap action
      - Menu
        - Adding List
        - Adding onTap action to redirect to details page
          - Add Buy button
        - Tips and Tricks
      - Profile
        - Add logout button

---

- Part 2

  - Add Firebase
    - Create project in Firebase
    - Setup Firebase for both Android and iOS, possibly (Web)
  - Add Firebase analytics
    - Add FlutterFire Core
    - Add FlutterFire Analytics
    - Explain why Analytics is important
    - Tips and Tricks
  - Securing Flutter
    - Adding authentication to Flutter
    - Adding Firebase Authentication plugin
    - Setup Social buttons

---

- Part 3

  - Add FireStore
    - Add Cloud_FireStore plugin
    - Introduction to NoSQL
    - Basic of Cloud_FireStore
    - Add list of coffees to fireStore from firebase dashboard
    - Read List of coffees
      - Introduction to json_serializable
      - Introduction to FutureBuilder and StreamBuilder
    - Write to firebase
      - Implement buy coffee
      - Implement order history
    - Introduction to permission in FireStore
      - securing write and read data

---

- Part 4

  - Cloud Functions

    - Write your backend code in the cloud (Serverless)
      - Prepare your project
      - Add your first function
      - Deploy
    - Integrate Cloud function with FireStore
      - Trigger function on certain events
    - Add Cloud Functions intro Flutter
      - call functions from Flutter

  - Cloud Storage
    - Adding Cloud Storage to Flutter
      - Upload photo
      - Read photo

---

Part 5

- Cloud messaging
  - Handling push messages
- In-app messaging
  - handling in-app messages
- Remote Config
  - Adding Remote config as feature flag feature
- Adding crashlytics
  - handle crashes and bugs

---

Part 6

- Adding Unit tests
  - Introduction to Flutter Test
  - Stubbing and Mocking
- Adding Widget Tests
  - Introduction to writing widgets test in Flutter
- Adding Integration test
  - Introduction to integration_test package
- Firebase Test lab
  - Run Test in the cloud in different devices
