import 'package:artriapp/models/index.dart';
import 'package:artriapp/services/physical_exercises_service.dart';
import 'package:flutter/foundation.dart';

class CustomRoutineViewModel extends ChangeNotifier {
  final PhysicalExercisesService _exerciseService;

  CustomRoutineTemplate? currentTemplate;
  final Map<String, List<Exercise>> selectedExercises = {};
  List<Exercise> catalog = [];

  CustomRoutineViewModel(this._exerciseService);

  /// Maps exercise IDs to category keys (mock until API supports categories).
  static const Map<int, String> _exerciseCategoryMap = {
    1001: 'mobilidade', 1002: 'mobilidade', 1003: 'mobilidade',
    1004: 'mobilidade', 1005: 'mobilidade',
    2001: 'aquecimento', 2002: 'aquecimento', 2003: 'aquecimento',
    3001: 'pernas', 3002: 'pernas', 3003: 'pernas',
    4001: 'bracos', 4002: 'bracos', 4003: 'bracos',
    4004: 'bracos', 4005: 'bracos',
    5001: 'tronco', 5002: 'tronco', 5003: 'tronco',
    6001: 'alongamento', 6002: 'alongamento', 6003: 'alongamento',
  };

  String _categoryForExercise(Exercise exercise) {
    return _exerciseCategoryMap[exercise.id] ?? 'outros';
  }

  List<Exercise> exercisesForCategory(String categoryKey) {
    return _categoryCatalog[categoryKey] ?? [];
  }

  bool isExerciseSelected(String categoryKey, int exerciseId) {
    return selectedExercises[categoryKey]?.any((e) => e.id == exerciseId) ?? false;
  }

  Map<String, List<Exercise>> _categoryCatalog = {};

  Future<void> initRoutine(String level) async {
    currentTemplate = CustomRoutineTemplate.mock(level);
    selectedExercises.clear();
    _categoryCatalog.clear();
    catalog = [];

    for (final cat in currentTemplate!.categories) {
      selectedExercises[cat.key] = [];
      _categoryCatalog[cat.key] = [];
    }

    try {
      catalog = await _exerciseService.getExercises();
      for (final exercise in catalog) {
        final cat = _categoryForExercise(exercise);
        if (_categoryCatalog.containsKey(cat)) {
          _categoryCatalog[cat]!.add(exercise);
        }
      }
    } catch (e) {
      debugPrint('[CustomRoutineViewModel] Failed to fetch catalog: $e');
    }

    notifyListeners();
  }

  bool toggleExercise(Exercise exercise, String category) {
    final list = selectedExercises[category];
    if (list == null) return false;

    final existingIndex = list.indexWhere((e) => e.id == exercise.id);
    if (existingIndex >= 0) {
      list.removeAt(existingIndex);
      notifyListeners();
      return true;
    }

    final cat = currentTemplate!.categories.firstWhere((c) => c.key == category);
    if (list.length >= cat.requiredCount) {
      debugPrint('[CustomRoutineViewModel] Category $category already at limit (${cat.requiredCount})');
      return false;
    }

    list.add(exercise);
    notifyListeners();
    return true;
  }

  bool isCategoryComplete(String category) {
    final cat = currentTemplate?.categories.firstWhere(
      (c) => c.key == category,
      orElse: () => TemplateCategory(key: category, title: '', requiredCount: 0, prepText: '', prompt: ''),
    );
    final selectedCount = selectedExercises[category]?.length ?? 0;
    return selectedCount >= cat!.requiredCount;
  }

  bool canStartRoutine() {
    final template = currentTemplate;
    if (template == null) return false;
    for (final cat in template.categories) {
      if (!isCategoryComplete(cat.key)) return false;
    }
    return true;
  }

  List<Exercise> generateFinalRoutine() {
    final template = currentTemplate;
    if (template == null) return [];

    final flattened = <Exercise>[];
    for (final cat in template.categories) {
      final selected = selectedExercises[cat.key] ?? [];
      flattened.addAll(selected);
    }
    return flattened;
  }
}
