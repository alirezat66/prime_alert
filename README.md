# Prime Alert

Prime Alert is a Flutter project designed to monitor and detect prime numbers from a random number API. The project follows the **MVVM (Model-View-ViewModel) architecture**, utilizing **Bloc for state management** and **Hydrated Bloc for persistence**. The application automatically switches between screens based on the detected prime numbers.

## Description

This application is designed to fetch random numbers, detect prime numbers, and display elapsed time since the last detected prime. It ensures maintainability, expandability, and reusability by following **best practices in state management, dependency injection, and routing**.

## Libraries Used

- **dio:** For making network requests.
- **pretty_dio_logger:** For logging network requests.
- **get_it:** For dependency injection.
- **mockito:** For mocking dependencies in tests.
- **flutter_bloc:** For state management.
- **equatable:** For value equality.
- **go_router:** For routing.
- **intl:** For internationalization.
- **gap:** For spacing widgets.
- **flutter_localizations:** For localization support.
- **hydrated_bloc:** For state persistence.
- **path_provider:** For accessing the file system.

## Why MVVM Why These libraries

We follow the **MVVM** architecture, which is recommended in the Flutter documentation. However, even if it weren’t recommended, I believe **Clean Architecture** is not ideal for small-scope projects due to its complexity.  

For state management, we use **hydrated_bloc**, which is well-suited for this type of application. With **hydrated_bloc**, we don’t need separate storage to temporarily save data and reload it when reopening the app, preventing tightly coupled dependencies in such cases.  

### Routing  
We use **go_router** for navigation, as it provides seamless support for both mobile and web versions of the application.  

### Testing  
For testing, we rely on:  
- **mockito** for mocking dependencies  
- **bloc_test** for testing Bloc logic  

### Dependency Injection  
We use **get_it** as our dependency injection framework and service locator.  

### Networking  
For API calls, we use **dio** along with **pretty_dio_logger** for logging network requests and responses.


## Tech Stack

- **Language:** Dart
- **Framework:** Flutter
- **State Management:** Bloc, Hydrated Bloc
- **Dependency Injection:** GetIt
- **Networking:** Dio
- **Routing:** GoRouter
- **Storage:** Hydrated Bloc (Local Persistence)

## Features

- **Prime Number Detection:** Fetches random numbers and determines if they are prime.
- **Auto-Routing:** Switches between screens based on prime detection.
- **Elapsed Time Counter:** Displays time elapsed since the last detected prime.
- **Local Persistence:** Uses Hydrated Bloc to store the last detected prime.
- **Dependency Injection:** Uses GetIt for efficient service management.
- **Dark Mode Theme Support**

## Folder Structure

```
lib/
├── core/
│   ├── di/
│   │   └── service_locator.dart
│   ├── extensions/
│   │   ├── context_ext.dart
│   │   ├── date_ext.dart
│   │   ├── duration_ext.dart
│   │   └── int_ext.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── config/
│   │   │   └── client_config.dart
│   │   ├── dio_client.dart
│   │   └── network_response.dart
│   ├── routing/
│   │   └── app_router.dart
│   └── theme/
│       └── dark_theme.dart
├── features/
│   ├── clock/
│   │   ├── cubit/
│   │   │   ├── date_cubit.dart
│   │   │   └── time_cubit.dart
│   │   └── view/
│   │       ├── clock_screen.dart
│   │       └── widgets/
│   │           ├── date_view.dart
│   │           └── timer_view.dart
│   └── random/
│       ├── cubit/
│       │   ├── elapsed_time_cubit.dart
│       │   ├── prime_number_cubit.dart
│       │   └── prime_number_state.dart
│       ├── model/
│       │   ├── data/
│       │   │   └── timed_number.dart
│       │   ├── polling_service.dart
│       │   ├── random_repository.dart
│       │   ├── random_repository_remote_impl.dart
│       │   └── timer_polling_service.dart
│       └── view/
│           ├── prime_screen.dart
│           └── widgets/
│               └── prime_view.dart
└── main.dart
```

## Routing

Prime Alert uses **GoRouter** for navigation:

- **Clock Screen:** Default screen where the clock is displayed.
- **Prime Screen:** Automatically navigates when a prime number is detected.
- **Redirect Logic:** If a prime number was detected before the app was closed, it redirects to the **Prime Screen** upon reopening.

```dart
final primeNumberCubit = locator<PrimeNumberCubit>();
final elapsedTimeCubit = locator<ElapsedTimeCubit>();

class AppRouter {
  static const String clockPath = '/';
  static const String primePath = '/prime';

  static final router = GoRouter(
    initialLocation: clockPath,
    routes: [
      GoRoute(
        path: clockPath,
        builder: (context, state) {
          primeNumberCubit.startPolling();
          return const ClockScreen();
        },
      ),
      GoRoute(
        path: primePath,
        builder: (context, state) {
          final primeState = context.read<PrimeNumberCubit>().state;
          if (primeState is PrimeNumberFound) {
            elapsedTimeCubit.startTimer(primeState.timedNumber.responseDate);
          }
          return const PrimeScreen();
        },
      ),
    ],
    redirect: (context, state) {
      final primeState = context.read<PrimeNumberCubit>().state;
      if (primeState is PrimeNumberFound && state.matchedLocation != primePath) {
        return primePath;
      }
      if (primeState is! PrimeNumberFound && state.matchedLocation == primePath) {
        return clockPath;
      }
      return null;
    },
  );
}
```

## State Management

### Prime Number Cubit

```dart
class PrimeNumberCubit extends HydratedCubit<PrimeNumberState> {
  final RandomRepository _repository;
  final PollingService _pollingService;
  StreamSubscription<void>? _subscription;

  PrimeNumberCubit({
    required RandomRepository randomRepository,
    required PollingService pollingService,
  })  : _repository = randomRepository,
        _pollingService = pollingService,
        super(PrimeNumberInitial());

  void startPolling() {
    if (state is PrimeNumberFound) return;
    _subscription?.cancel();
    _subscription = _pollingService.pollingStream.listen((_) async {
      await _checkNumber();
    });
    _pollingService.startPolling();
  }
}
```

### Elapsed Time Cubit

```dart
class ElapsedTimeCubit extends Cubit<Duration?> {
  ElapsedTimeCubit() : super(null);
  Timer? _timer;

  void startTimer(DateTime lastPrimeDate) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(DateTime.now().difference(lastPrimeDate));
    });
  }
}
```

## UI Components

### Clock Screen

Displays the current time and date, updating in real-time.

```dart
class ClockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<TimeCubit>()),
        BlocProvider(create: (_) => locator<DateCubit>()),
      ],
      child: BlocListener<PrimeNumberCubit, PrimeNumberState>(
        listener: (context, state) {
          context.go(AppRouter.primePath);
        },
        child: const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TimerView(),
                Gap(24),
                DateView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
## Release Web Version

You can access the release web version of the application [here](https://alirezat66.github.io/prime_alert_web/).

## Demo  
[Live Preview](https://alirezat66.github.io/prime_alert_web/)

## Conclusion

**Prime Alert** is a well-structured **Flutter MVVM project** that efficiently detects and monitors prime numbers. It leverages **Bloc, Hydrated Bloc, GoRouter, and Dio** to provide a smooth and maintainable architecture.

