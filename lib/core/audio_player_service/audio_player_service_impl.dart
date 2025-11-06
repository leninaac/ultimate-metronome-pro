import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../consts/audios/app_audios.dart';
import 'audio_player_service.dart';

class AudioPlayerServiceImpl implements AudioPlayerService {
  final AudioPlayer _tick1Player;
  final AudioPlayer _tick2Player;
  bool _initialized = false;

  AudioPlayerServiceImpl()
      : _tick1Player = AudioPlayer(),
        _tick2Player = AudioPlayer();

  @override
  bool get isInitialized => _initialized;

  @override
  Future<void> init({required String tick1Path, required String tick2Path}) async {
    if (_initialized) return;

    try {
      await startPlayer();
      await preloadSounds(tick1Path, tick2Path);
      _initialized = true;
      debugPrint('AudioPlayerService initialized com $tick1Path e $tick2Path');
    } catch (e) {
      debugPrint('Erro ao inicializar AudioPlayerService: $e');
      rethrow;
    }
  }

  @override
  Future<void> startPlayer() async {
    await _tick1Player.setPlayerMode(PlayerMode.lowLatency);
    await _tick2Player.setPlayerMode(PlayerMode.lowLatency);
  }

  @override
  Future<void> preloadSounds(String tick1Path, String tick2Path) async {
    try {
      // Define a fonte para cada player. Isso muitas vezes pré-carrega o áudio no buffer.
      await _tick1Player.setSource(AssetSource(tick1Path));
      await _tick2Player.setSource(AssetSource(tick2Path));
      debugPrint('Sons de tick definidos como fontes.');
    } catch (e) {
      debugPrint('Aviso: Falha ao definir fontes de áudio para pré-carregamento: $e');
      // Não re-lança, pois o play pode funcionar mesmo se o setSource falhar em alguns contextos.
    }
  }


  @override
  Future<void> playSound(String path) async {
    final AudioPlayer player = path == AppAudios.tick1Audio ? _tick1Player : _tick2Player;

    try {
      // **IMPORTANTE:** Se você estiver usando PlayerMode.lowLatency,
      // é crucial chamar stop/resume antes de tocar para evitar travamentos.
      await player.stop();
      await player.resume();

      // Toca a partir da fonte que já foi definida em preloadSounds
      await player.play(AssetSource(path));

    } catch (e) {
      debugPrint('Erro ao tocar áudio ($path): $e');
    }
  }

  @override
  void dispose() {
    _tick1Player.dispose();
    _tick2Player.dispose();
  }

  @override
  Future<void> updateTickSounds(String tick1Path, String tick2Path) {
    // TODO: implement updateTickSounds
    throw UnimplementedError();
  }
}
