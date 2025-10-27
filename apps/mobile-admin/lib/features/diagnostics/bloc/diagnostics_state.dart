part of 'diagnostics_bloc.dart';

sealed class DiagnosticsState extends Equatable {
  const DiagnosticsState();

  @override
  List<Object?> get props => [];
}

class DiagnosticsInitial extends DiagnosticsState {}

class DiagnosticsLoading extends DiagnosticsState {}

class DiagnosticsReady extends DiagnosticsState {
  final ScooterModel scooter;
  final List<DiagnosticTest> tests;
  final int overallProgress;

  const DiagnosticsReady({
    required this.scooter,
    required this.tests,
    required this.overallProgress,
  });

  @override
  List<Object?> get props => [scooter, tests, overallProgress];
}

class DiagnosticsInProgress extends DiagnosticsState {
  final ScooterModel scooter;
  final List<DiagnosticTest> tests;
  final int overallProgress;
  final int currentTestIndex;

  const DiagnosticsInProgress({
    required this.scooter,
    required this.tests,
    required this.overallProgress,
    required this.currentTestIndex,
  });

  @override
  List<Object?> get props => [scooter, tests, overallProgress, currentTestIndex];
}

class DiagnosticsCompleted extends DiagnosticsState {
  final DiagnosticsSummary summary;

  const DiagnosticsCompleted({required this.summary});

  @override
  List<Object?> get props => [summary];
}

class DiagnosticsError extends DiagnosticsState {
  final String message;

  const DiagnosticsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DiagnosticTest {
  final String name;
  final TestStatus status;
  final String description;
  final TestResult? result;
  final String? details;

  DiagnosticTest({
    required this.name,
    required this.status,
    required this.description,
    this.result,
    this.details,
  });

  DiagnosticTest copyWith({
    String? name,
    TestStatus? status,
    String? description,
    TestResult? result,
    String? details,
  }) {
    return DiagnosticTest(
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
      result: result ?? this.result,
      details: details ?? this.details,
    );
  }
}

enum TestStatus {
  pending,
  running,
  completed,
}

enum TestResult {
  passed,
  warning,
  failed,
}

enum DiagnosticsStatus {
  passed,
  warning,
  failed,
}

class DiagnosticsSummary {
  final ScooterModel scooter;
  final String completedAt;
  final int totalTests;
  final int passedTests;
  final int warningTests;
  final int failedTests;
  final DiagnosticsStatus overallStatus;
  final List<DiagnosticTest> tests;
  final List<String> recommendations;

  DiagnosticsSummary({
    required this.scooter,
    required this.completedAt,
    required this.totalTests,
    required this.passedTests,
    required this.warningTests,
    required this.failedTests,
    required this.overallStatus,
    required this.tests,
    required this.recommendations,
  });
}
