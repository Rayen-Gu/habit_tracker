import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _todoKey = 'todo_tasks';
  static const _doneKey = 'done_tasks';

  Future<void> saveTasks(List<String> todo, List<String> done) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_todoKey, todo);
    await prefs.setStringList(_doneKey, done);
  }

  Future<Map<String, List<String>>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final todo = prefs.getStringList(_todoKey) ?? [];
    final done = prefs.getStringList(_doneKey) ?? [];
    return {'todo': todo, 'done': done};
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_todoKey);
    await prefs.remove(_doneKey);
  }
}
