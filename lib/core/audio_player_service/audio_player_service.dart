abstract class AudioPlayerService {
  Future<void> startPlayer();
  Future<void> preloadSounds(String tick1Path, String tick2Path);
  Future<void> playSound(String path);
  Future<void> init({required String tick1Path, required String tick2Path});
  Future<void> updateTickSounds(String tick1Path, String tick2Path); // futuro
  bool get isInitialized; // expose initialization flag
  void dispose();
}