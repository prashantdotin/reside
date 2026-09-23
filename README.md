# Flutter Test App

A responsive Flutter implementation of the Reside Manager's Team View interview design.

## Implemented

- Manager's Team View dashboard
- Team member selection
- Duration selection: Today, Week, Month, Quarter, Annual, Till Date and Date Range
- Team Performance with per-member task breakdown and donut visualization
- Team's Task screen with Open, Overdue and Closed tabs
- Task filtering by team member
- Task sorting by due date and title
- Empty state when a filter produces no tasks
- Back navigation across screens
- Responsive layouts using Flutter's normal constraints and scrolling primitives
- Local mock data with a single task model used by dashboard, performance and task screens

## Project structure

```text
lib/
├── controllers/       # UI/business state
├── core/              # constants, theme and formatters
├── data/              # mock data
├── models/             # task and team-member models
├── screens/            # dashboard, performance and task screens
└── widgets/            # reusable cards, charts, filters and controls
```

## Setup

1. Install Flutter 3.x and run `flutter doctor`.
2. Open this folder in Android Studio or VS Code.
3. Run `flutter pub get`.
4. Run `flutter run` on an Android/iOS device or emulator.
5. Run `dart format lib` before committing changes.
6. Run `flutter analyze` to check the project.

The assignment intentionally uses local mock data because no backend/API contract was supplied.
