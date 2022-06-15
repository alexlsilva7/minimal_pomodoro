import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

enum TipoIntervalo { TRABALHO, DESCANSO }

class PomodoroController extends GetxController {
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  var minutos = 25.obs;

  var segundos = 0.obs;

  var tempoTrabalho = 25.obs;

  var tempoDescanso = 5.obs;

  var iniciado = false.obs;

  var reiniciado = false.obs;

  Timer? cronometro;

  void iniciar() {
    iniciado.value = true;
    reiniciado.value = false;
    cronometro = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (minutos.value == 0 && segundos.value == 0) {
        _trocarTipoIntervalo();
      } else if (segundos.value == 0) {
        segundos.value = 59;
        minutos.value--;
      } else {
        segundos.value--;
      }
    });
  }

  void parar() {
    iniciado.value = false;
    cronometro?.cancel();
  }

  void reiniciar() {
    parar();
    minutos.value =
        estaTrabalhando() ? tempoTrabalho.value : tempoDescanso.value;
    segundos.value = 0;
    reiniciado.value = true;
  }

  void incrementarTempoTrabalho() {
    if (tempoTrabalho.value < 120) {
      tempoTrabalho.value++;
    }
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  void setTempoTrabalho(int tempo) {
    if (tempo < 120 && tempo > 0) {
      tempoTrabalho.value = tempo;
    }
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  void setTempoDescanso(int tempo) {
    if (tempo < 120 && tempo > 0) {
      tempoDescanso.value = tempo;
    }
    if (estaDescansando()) {
      reiniciar();
    }
  }

  void decrementarTempoTrabalho() {
    if (tempoTrabalho.value > 1) {
      tempoTrabalho.value--;
    }
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  void incrementarTempoDescanso() {
    if (tempoDescanso.value < 120) {
      tempoDescanso.value++;
    }

    if (estaDescansando()) {
      reiniciar();
    }
  }

  void decrementarTempoDescanso() {
    if (tempoDescanso.value > 1) {
      tempoDescanso.value--;
    }
    if (estaDescansando()) {
      reiniciar();
    }
  }

  bool estaTrabalhando() {
    return tipoIntervalo == TipoIntervalo.TRABALHO;
  }

  bool estaDescansando() {
    return tipoIntervalo == TipoIntervalo.DESCANSO;
  }

  AudioPlayer player = AudioPlayer();
  Future<void> playBell() async {
    await player.setSource(AssetSource('sound/bell.mp3'));
    await player.setVolume(1);
    await player.resume();
  }

  void _trocarTipoIntervalo() {
    playBell();
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos.value = tempoDescanso.value;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos.value = tempoTrabalho.value;
    }
    segundos.value = 0;
  }
}
