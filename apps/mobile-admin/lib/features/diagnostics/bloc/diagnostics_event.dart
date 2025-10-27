part of 'diagnostics_bloc.dart';

sealed class DiagnosticsEvent extends Equatable {
  const DiagnosticsEvent();

  @override
  List<Object?> get props => [];
}

class StartDiagnosticsRequested extends DiagnosticsEvent {
  final ScooterModel scooter;

  const StartDiagnosticsRequested({required this.scooter});

  @override
  List<Object?> get props => [scooter];
}

class RunSystemCheckRequested extends DiagnosticsEvent {
  const RunSystemCheckRequested();
}

class TestMotorRequested extends DiagnosticsEvent {
  const TestMotorRequested();
}

class TestBrakesRequested extends DiagnosticsEvent {
  const TestBrakesRequested();
}

class TestLightsRequested extends DiagnosticsEvent {
  const TestLightsRequested();
}

class TestConnectivityRequested extends DiagnosticsEvent {
  const TestConnectivityRequested();
}

class CompleteDiagnosticsRequested extends DiagnosticsEvent {
  const CompleteDiagnosticsRequested();
}

class DiagnosticsProgressUpdated extends DiagnosticsEvent {
  final List<DiagnosticTest> tests;
  final int progress;

  const DiagnosticsProgressUpdated({
    required this.tests,
    required this.progress,
  });

  @override
  List<Object?> get props => [tests, progress];
}
