import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum TipoIntervalo { FOCO, DESCANSO }

class PomodoroController extends GetxController {
  TipoIntervalo tipoIntervalo = TipoIntervalo.FOCO;
  final box = GetStorage();
  @override
  void onInit() {
    var foco = box.read('tempoFoco');
    if (foco != null) {
      tempoFoco.value = foco;
      minutos.value = foco;
    }
    var descanso = box.read('tempoDescanso');
    if (descanso != null) {
      tempoDescanso.value = descanso;
    }
    super.onInit();
  }

  var minutos = 25.obs;

  var segundos = 0.obs;

  var tempoFoco = 25.obs;

  var tempoDescanso = 5.obs;

  var iniciado = false.obs;

  var reiniciado = false.obs;

  Timer? cronometro;

  void iniciar() {
    iniciado.value = true;
    reiniciado.value = false;
    cronometro = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    minutos.value = estaFocado() ? tempoFoco.value : tempoDescanso.value;
    segundos.value = 0;
    reiniciado.value = true;
  }

  void setTempoFoco(int tempo) {
    if (tempo < 120 && tempo > 0) {
      tempoFoco.value = tempo;
      box.write('tempoFoco', tempo);
    }
    if (estaFocado()) {
      reiniciar();
    }
  }

  void setTempoDescanso(int tempo) {
    if (tempo < 120 && tempo > 0) {
      tempoDescanso.value = tempo;
      box.write('tempoDescanso', tempo);
    }
    if (estaDescansando()) {
      reiniciar();
    }
  }

  bool estaFocado() {
    return tipoIntervalo == TipoIntervalo.FOCO;
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
    if (estaFocado()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos.value = tempoDescanso.value;
    } else {
      tipoIntervalo = TipoIntervalo.FOCO;
      minutos.value = tempoFoco.value;
    }
    segundos.value = 0;
  }
}
