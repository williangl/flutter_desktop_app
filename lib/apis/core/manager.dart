abstract class Manager {
  Future<bool> stop();
  Future<bool> start();
  Future<int> processes();
}
