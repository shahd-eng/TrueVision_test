# True Vision - Clean Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns.

## Project Structure

```
lib/
├── core/                    # Core utilities and constants
│   └── utils/
│       └── app_colors.dart
│
├── data/                    # Data Layer
│   ├── datasources/         # Data sources (remote, local)
│   │   ├── dashboard_remote_datasource.dart
│   │   └── dashboard_remote_datasource_impl.dart
│   ├── models/              # Data models (DTOs)
│   │   ├── user_model.dart
│   │   ├── trending_item_model.dart
│   │   └── recent_detection_model.dart
│   └── repositories/        # Repository implementations
│       └── dashboard_repository_impl.dart
│
├── domain/                  # Domain Layer (Business Logic)
│   ├── entities/            # Business entities
│   │   ├── user.dart
│   │   ├── trending_item.dart
│   │   └── recent_detection.dart
│   └── repositories/        # Repository contracts (abstract)
│       └── dashboard_repository.dart
│
├── presentation/            # Presentation Layer (UI)
│   └── dashboard/
│       ├── cubit/           # State management
│       │   ├── dashboard_cubit.dart
│       │   └── dashboard_state.dart
│       ├── pages/           # Full screen widgets
│       │   └── dashboard_page.dart
│       └── widgets/         # Reusable UI components
│           ├── dashboard_header.dart
│           ├── dashboard_bottom_nav_bar.dart
│           ├── trending_section.dart
│           ├── trending_card.dart
│           └── recent_detections_section.dart
│
├── injection.dart           # Dependency injection
└── main.dart                # App entry point
```

## Dependency Rule

- **Domain** has no dependencies on other layers
- **Data** depends only on **Domain**
- **Presentation** depends on **Domain** (and **Data** only via DI)

## Key Concepts

- **Entities**: Pure business objects
- **Repositories**: Abstract contracts in domain, implementations in data
- **Use Cases**: Business logic (can be added in domain/usecases/ when needed)
- **Cubit**: State management (Bloc pattern)
- **Widgets**: Small, focused, reusable UI components
