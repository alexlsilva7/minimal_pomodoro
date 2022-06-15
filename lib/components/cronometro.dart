import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pomodoro/controllers/pomodoro_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Cronometro extends StatefulWidget {
  const Cronometro({Key? key}) : super(key: key);

  @override
  State<Cronometro> createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro>
    with SingleTickerProviderStateMixin {
  late AnimationController playPauseController;

  @override
  void initState() {
    super.initState();
    playPauseController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
  }

  final store = Get.find<PomodoroController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 245,
                  height: 245,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.deepPurple,
                        Color.fromARGB(255, 23, 18, 32)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 23, 18, 32),
                  ),
                ),
                CircularPercentIndicator(
                  radius: 120,
                  progressColor: store.estaFocado()
                      ? Colors.deepPurple.withOpacity(0.05)
                      : Colors.green.withOpacity(0.05),
                  backgroundColor: store.estaFocado()
                      ? Colors.deepPurple.withOpacity(0.001)
                      : Colors.green.withOpacity(0.001),
                  percent: store.minutos.value == 0 && store.segundos.value == 0
                      ? 0
                      : store.estaFocado()
                          ? ((((store.minutos.value * 60 +
                                              store.segundos.value) *
                                          100) /
                                      (store.tempoFoco.value * 60)) /
                                  100)
                              .toPrecision(3)
                          : ((((store.minutos.value * 60 +
                                              store.segundos.value) *
                                          100) /
                                      (store.tempoDescanso.value * 60)) /
                                  100)
                              .toPrecision(2),
                  lineWidth: 10,
                  animateFromLastPercent: true,
                ),
                CircularPercentIndicator(
                  radius: 110,
                  progressColor:
                      store.estaFocado() ? Colors.deepPurple : Colors.green,
                  backgroundColor: store.estaFocado()
                      ? Colors.deepPurple.withOpacity(0.5)
                      : Colors.green.withOpacity(0.5),
                  percent: store.minutos.value == 0 && store.segundos.value == 0
                      ? 0
                      : store.estaFocado()
                          ? ((((store.minutos.value * 60 +
                                              store.segundos.value) *
                                          100) /
                                      (store.tempoFoco.value * 60)) /
                                  100)
                              .toPrecision(3)
                          : ((((store.minutos.value * 60 +
                                              store.segundos.value) *
                                          100) /
                                      (store.tempoDescanso.value * 60)) /
                                  100)
                              .toPrecision(2),
                  lineWidth: 10,
                  animateFromLastPercent: true,
                ),
                Text(
                  '${store.minutos.toString().padLeft(2, "0")}:${store.segundos.toString().padLeft(2, "0")}',
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                Positioned(
                  bottom: 60,
                  child: IconButton(
                      onPressed: store.iniciado.value ? null : store.reiniciar,
                      iconSize: 22,
                      icon: Icon(
                        Icons.refresh,
                        color: store.iniciado.value || store.reiniciado.value
                            ? Colors.transparent
                            : Colors.white.withOpacity(0.9),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        store.estaFocado() ? Colors.deepPurple : Colors.green,
                        const Color.fromARGB(255, 52, 32, 87),
                        const Color.fromARGB(255, 23, 18, 32)
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor:
                      store.estaFocado() ? Colors.deepPurple : Colors.green,
                  child: IconButton(
                    iconSize: 30,
                    splashRadius: 10,
                    onPressed: () {
                      if (store.iniciado.value) {
                        store.parar();
                        setState(() {
                          playPauseController.reverse();
                        });
                      } else {
                        store.iniciar();

                        setState(() {
                          playPauseController.forward();
                        });
                      }
                    },
                    icon: AnimatedIcon(
                      progress: playPauseController,
                      icon: AnimatedIcons.play_pause,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
