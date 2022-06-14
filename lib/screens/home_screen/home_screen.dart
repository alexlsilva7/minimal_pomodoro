import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pomodoro/components/cronometro.dart';
import 'package:minimal_pomodoro/components/entrada_tempo.dart';
import 'package:minimal_pomodoro/controllers/pomodoro_controller.dart';
import 'package:minimal_pomodoro/screens/settings_screen/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Get.find<PomodoroController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimal Pomodoro',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
              iconSize: 20,
              onPressed: () {
                Get.to(() => const SettingsScreen());
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white.withOpacity(0.9),
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: Cronometro()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    valor: store.tempoTrabalho.value,
                    titulo: 'Trabalho',
                    inc: store.iniciado.value && store.estaTrabalhando()
                        ? null
                        : store.incrementarTempoTrabalho,
                    dec: store.iniciado.value && store.estaTrabalhando()
                        ? null
                        : store.decrementarTempoTrabalho,
                  ),
                  EntradaTempo(
                    valor: store.tempoDescanso.value,
                    titulo: 'Descanso',
                    inc: store.iniciado.value && store.estaDescansando()
                        ? null
                        : store.incrementarTempoDescanso,
                    dec: store.iniciado.value && store.estaDescansando()
                        ? null
                        : store.decrementarTempoDescanso,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
