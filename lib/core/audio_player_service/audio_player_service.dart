abstract class AudioPlayerService {
  Future<void> preloadSounds();
  Future<void> playPrimaryTick();
  Future<void> playSecondaryTick();
  void dispose();
}