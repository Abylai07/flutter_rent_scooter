import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobility_hub_shared/core/models/scooter/scooter_model.dart';

part 'diagnostics_event.dart';
part 'diagnostics_state.dart';

class DiagnosticsBloc extends Bloc<DiagnosticsEvent, DiagnosticsState> {
  Timer? _diagnosticsTimer;
  int _currentTestIndex = 0;

  DiagnosticsBloc() : super(DiagnosticsInitial()) {
    on<StartDiagnosticsRequested>(_onStartDiagnostics);
    on<RunSystemCheckRequested>(_onRunSystemCheck);
    on<TestMotorRequested>(_onTestMotor);
    on<TestBrakesRequested>(_onTestBrakes);
    on<TestLightsRequested>(_onTestLights);
    on<TestConnectivityRequested>(_onTestConnectivity);
    on<CompleteDiagnosticsRequested>(_onCompleteDiagnostics);
    on<DiagnosticsProgressUpdated>(_onProgressUpdated);
  }

  Future<void> _onStartDiagnostics(
    StartDiagnosticsRequested event,
    Emitter<DiagnosticsState> emit,
  ) async {
    emit(DiagnosticsLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final tests = <DiagnosticTest>[
        DiagnosticTest(
          name: 'System Status',
          status: TestStatus.pending,
          description: 'Check overall system health',
        ),
        DiagnosticTest(
          name: 'Motor Function',
          status: TestStatus.pending,
          description: 'Test motor response and power',
        ),
        DiagnosticTest(
          name: 'Brake System',
          status: TestStatus.pending,
          description: 'Verify brake functionality',
        ),
        DiagnosticTest(
          name: 'Lights & Signals',
          status: TestStatus.pending,
          description: 'Check all lighting systems',
        ),
        DiagnosticTest(
          name: 'Network Connectivity',
          status: TestStatus.pending,
          description: 'Test GPS and cellular connection',
        ),
      ];

      emit(DiagnosticsReady(
        scooter: event.scooter,
        tests: tests,
        overallProgress: 0,
      ));

      add(RunSystemCheckRequested());
    } catch (e) {
      emit(DiagnosticsError(message: e.toString()));
    }
  }

  Future<void> _onRunSystemCheck(
    RunSystemCheckRequested event,
    Emitter<DiagnosticsState> emit,
  ) async {
    if (state is! DiagnosticsReady && state is! DiagnosticsInProgress) return;

    final currentState = state is DiagnosticsReady
        ? state as DiagnosticsReady
        : (state as DiagnosticsInProgress);

    _currentTestIndex = 0;

    emit(DiagnosticsInProgress(
      scooter: currentState.scooter,
      tests: _updateTestStatus(currentState.tests, 0, TestStatus.running),
      overallProgress: 0,
      currentTestIndex: 0,
    ));

    await Future.delayed(const Duration(seconds: 2));

    final batteryOk = currentState.scooter.batteryLevel > 10;
    final result = batteryOk ? TestResult.passed : TestResult.warning;

    final updatedTests = _updateTestResult(
      currentState.tests,
      0,
      result,
      batteryOk ? 'All systems operational' : 'Low battery detected',
    );

    add(DiagnosticsProgressUpdated(
      tests: updatedTests,
      progress: 20,
    ));

    add(TestMotorRequested());
  }

  Future<void> _onTestMotor(
    TestMotorRequested event,
    Emitter<DiagnosticsState> emit,
  ) async {
    if (state is! DiagnosticsInProgress) return;

    final currentState = state as DiagnosticsInProgress;
    _currentTestIndex = 1;

    emit(DiagnosticsInProgress(
      scooter: currentState.scooter,
      tests: _updateTestStatus(currentState.tests, 1, TestStatus.running),
      overallProgress: 20,
      currentTestIndex: 1,
    ));

    await Future.delayed(const Duration(seconds: 3));

    final result = _randomTestResult();
    final updatedTests = _updateTestResult(
      currentState.tests,
      1,
      result,
      result == TestResult.passed
          ? 'Motor functioning normally'
          : 'Motor response delayed',
    );

    add(DiagnosticsProgressUpdated(
      tests: updatedTests,
      progress: 40,
    ));

    add(TestBrakesRequested());
  }

  Future<void> _onTestBrakes(
    TestBrakesRequested event,
    Emitter<DiagnosticsState> emit,
  ) async {
    if (state is! DiagnosticsInProgress) return;

    final currentState = state as DiagnosticsInProgress;
    _currentTestIndex = 2;

    emit(DiagnosticsInProgress(
      scooter: currentState.scooter,
      tests: _updateTestStatus(currentState.tests, 2, TestStatus.running),
      overallProgress: 40,
      currentTestIndex: 2,
    ));

    await Future.delayed(const Duration(seconds: 2));

    final result = _randomTestResult();
    final updatedTests = _updateTestResult(
      currentState.tests,
      2,
      result,
      result == TestResult.passed ? 'Brakes responding correctly' : 'Brake wear detected',
    );

    add(DiagnosticsProgressUpdated(
      tests: updatedTests,
      progress: 60,
    ));

    add(TestLightsRequested());
  }

  Future<void> _onTestLights(
    TestLightsRequested event,
    Emitter<DiagnosticsState> emit,
  ) async {
    if (state is! DiagnosticsInProgress) return;

    final currentState = state as DiagnosticsInProgress;
    _currentTestIndex = 3;

    emit(DiagnosticsInProgress(
      scooter: currentState.scooter,
      tests: _updateTestStatus(currentState.tests, 3, TestStatus.running),
      overallProgress: 60,
      currentTestIndex: 3,
    ));

    await Future.delayed(const Duration(milliseconds: 1500));

    final result = TestResult.passed;
    final updatedTests = _updateTestResult(
      currentState.tests,
      3,
      result,
      'All lights functional',
    );

    add(DiagnosticsProgressUpdated(
      tests: updatedTests,
      progress: 80,
    ));

    add(TestConnectivityRequested());
  }

  Future<void> _onTestConnectivity(
    TestConnectivityRequested event,
    Emitter<DiagnosticsState> emit,
  ) async {
    if (state is! DiagnosticsInProgress) return;

    final currentState = state as DiagnosticsInProgress;
    _currentTestIndex = 4;

    emit(DiagnosticsInProgress(
      scooter: currentState.scooter,
      tests: _updateTestStatus(currentState.tests, 4, TestStatus.running),
      overallProgress: 80,
      currentTestIndex: 4,
    ));

    await Future.delayed(const Duration(seconds: 2));

    final result = TestResult.passed;
    final updatedTests = _updateTestResult(
      currentState.tests,
      4,
      result,
      'GPS and network connected',
    );

    add(DiagnosticsProgressUpdated(
      tests: updatedTests,
      progress: 100,
    ));

    add(CompleteDiagnosticsRequested());
  }

  Future<void> _onCompleteDiagnostics(
    CompleteDiagnosticsRequested event,
    Emitter<DiagnosticsState> emit,
  ) async {
    if (state is! DiagnosticsInProgress) return;

    final currentState = state as DiagnosticsInProgress;

    await Future.delayed(const Duration(seconds: 1));

    final passedTests = currentState.tests.where((t) => t.result == TestResult.passed).length;
    final warningTests = currentState.tests.where((t) => t.result == TestResult.warning).length;
    final failedTests = currentState.tests.where((t) => t.result == TestResult.failed).length;

    final summary = DiagnosticsSummary(
      scooter: currentState.scooter,
      completedAt: DateTime.now().toIso8601String(),
      totalTests: currentState.tests.length,
      passedTests: passedTests,
      warningTests: warningTests,
      failedTests: failedTests,
      overallStatus: failedTests > 0
          ? DiagnosticsStatus.failed
          : warningTests > 0
              ? DiagnosticsStatus.warning
              : DiagnosticsStatus.passed,
      tests: currentState.tests,
      recommendations: _generateRecommendations(currentState.tests),
    );

    emit(DiagnosticsCompleted(summary: summary));
  }

  void _onProgressUpdated(
    DiagnosticsProgressUpdated event,
    Emitter<DiagnosticsState> emit,
  ) {
    if (state is! DiagnosticsInProgress) return;

    final currentState = state as DiagnosticsInProgress;

    emit(DiagnosticsInProgress(
      scooter: currentState.scooter,
      tests: event.tests,
      overallProgress: event.progress,
      currentTestIndex: currentState.currentTestIndex,
    ));
  }

  List<DiagnosticTest> _updateTestStatus(
    List<DiagnosticTest> tests,
    int index,
    TestStatus status,
  ) {
    return List.generate(tests.length, (i) {
      if (i == index) {
        return tests[i].copyWith(status: status);
      }
      return tests[i];
    });
  }

  List<DiagnosticTest> _updateTestResult(
    List<DiagnosticTest> tests,
    int index,
    TestResult result,
    String details,
  ) {
    return List.generate(tests.length, (i) {
      if (i == index) {
        return tests[i].copyWith(
          status: TestStatus.completed,
          result: result,
          details: details,
        );
      }
      return tests[i];
    });
  }

  TestResult _randomTestResult() {
    final random = DateTime.now().millisecond % 10;
    if (random < 7) return TestResult.passed;
    if (random < 9) return TestResult.warning;
    return TestResult.failed;
  }

  List<String> _generateRecommendations(List<DiagnosticTest> tests) {
    final recommendations = <String>[];

    for (final test in tests) {
      if (test.result == TestResult.failed) {
        recommendations.add('URGENT: ${test.name} requires immediate attention');
      } else if (test.result == TestResult.warning) {
        recommendations.add('${test.name} should be checked soon');
      }
    }

    if (recommendations.isEmpty) {
      recommendations.add('Scooter is in good condition');
      recommendations.add('Schedule next maintenance in 7 days');
    }

    return recommendations;
  }

  @override
  Future<void> close() {
    _diagnosticsTimer?.cancel();
    return super.close();
  }
}
