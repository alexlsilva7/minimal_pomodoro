import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pomodoro/controllers/pomodoro_controller.dart';
import 'package:numberpicker/numberpicker.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({Key? key}) : super(key: key);

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  final store = Get.find<PomodoroController>();
  late int tempoFoco;
  late int tempoDescanso;
  List<bool> expansionsOpen = [true, false];

  @override
  void initState() {
    tempoFoco = store.tempoTrabalho.value;
    tempoDescanso = store.tempoDescanso.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ExpansionPanelList(
                    expansionCallback: ((panelIndex, isExpanded) =>
                        setState(() {
                          expansionsOpen = [false, false];
                          expansionsOpen[panelIndex] = !isExpanded;
                        })),
                    children: [
                      ExpansionPanel(
                        backgroundColor: Colors.white.withOpacity(0.05),
                        isExpanded: expansionsOpen[0],
                        headerBuilder: (ctx, open) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Foco: $tempoFoco min',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        body: Row(
                          children: [
                            Expanded(
                              child: NumberPicker(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 132, 87, 184),
                                    backgroundBlendMode: BlendMode.colorDodge,
                                  ),
                                  selectedTextStyle: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                  value: tempoFoco,
                                  minValue: 0,
                                  maxValue: 120,
                                  onChanged: (value) {
                                    setState(() {
                                      tempoFoco = value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      ExpansionPanel(
                        backgroundColor: Colors.white.withOpacity(0.05),
                        isExpanded: expansionsOpen[1],
                        headerBuilder: (ctx, open) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Descanso: $tempoDescanso min',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        body: Row(
                          children: [
                            Expanded(
                              child: NumberPicker(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 132, 87, 184),
                                    backgroundBlendMode: BlendMode.colorDodge,
                                  ),
                                  selectedTextStyle: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                  value: tempoDescanso,
                                  minValue: 0,
                                  maxValue: 120,
                                  onChanged: (value) {
                                    setState(() {
                                      tempoDescanso = value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          store.setTempoTrabalho(tempoFoco);
                          store.setTempoDescanso(tempoDescanso);
                          Get.back();
                        },
                        child: const Text(
                          'Salvar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sound from Zapsplat.com',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
