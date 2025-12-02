// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false, isBreakTime = false;
  int totalPomodoros = 0;
  int totalGoal = 0;
  late Timer timer;
  int pomotime = 25;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        if (totalPomodoros == 3) {
          totalGoal = totalGoal + 1;
          isBreakTime = true;
        }
        if (totalPomodoros == 4) {
          if (isBreakTime) {
            totalPomodoros = 0;
            isBreakTime = false;
            totalSeconds = pomotime * 60;
          } else {
            totalPomodoros = 1;
          }
        } else {
          totalPomodoros = totalPomodoros + 1;
        }
        if (isBreakTime) {
          totalSeconds = 5 * 60;
        } else {
          totalSeconds = pomotime * 60;
        }
      });

      if (totalGoal == 12) {
        //totalPomodoros = 0;
        //totalGoal = 0;
        totalSeconds = 0;
        timer.cancel();
        isRunning = false;
      }
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(microseconds: 5000),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPomoTime(int ptime) {
    if (isRunning) {
      onPausePressed();
    }
    totalSeconds = ptime * 60;
    setState(() {
      pomotime = ptime;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = pomotime * 60;
      totalGoal = 0;
      totalPomodoros = 0;
    });
  }

  String formatHH(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4);
  }

  String formatMM(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe64e3e),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'POMOTIMER',
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      formatHH(totalSeconds),
                      style: const TextStyle(
                        color: Color(0xFFe64e3e),
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyle(
                      color: Colors.white30,
                      fontSize: 50,
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      formatMM(totalSeconds),
                      style: const TextStyle(
                        color: Color(0xFFe64e3e),
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: pomotime == 15
                          ? Colors.white
                          : const Color(0xFFe64e3e),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        onPomoTime(15);
                      },
                      child: Text(
                        '15',
                        style: TextStyle(
                          color: pomotime == 15
                              ? const Color(0xFFe64e3e)
                              : Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: pomotime == 20
                          ? Colors.white
                          : const Color(0xFFe64e3e),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        onPomoTime(20);
                      },
                      child: Text(
                        '20',
                        style: TextStyle(
                          color: pomotime == 20
                              ? const Color(0xFFe64e3e)
                              : Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: pomotime == 25
                          ? Colors.white
                          : const Color(0xFFe64e3e),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        onPomoTime(25);
                      },
                      child: Text(
                        '25',
                        style: TextStyle(
                          color: pomotime == 25
                              ? const Color(0xFFe64e3e)
                              : Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: pomotime == 30
                          ? Colors.white
                          : const Color(0xFFe64e3e),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        onPomoTime(30);
                      },
                      child: Text(
                        '30',
                        style: TextStyle(
                          color: pomotime == 30
                              ? const Color(0xFFe64e3e)
                              : Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: pomotime == 35
                          ? Colors.white
                          : const Color(0xFFe64e3e),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 40),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        onPomoTime(35);
                      },
                      child: Text(
                        '35',
                        style: TextStyle(
                          color: pomotime == 35
                              ? const Color(0xFFe64e3e)
                              : Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    iconSize: 90,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                  ),
                ),
                Center(
                  child: IconButton(
                    iconSize: 40,
                    color: Theme.of(context).cardColor,
                    onPressed: onResetPressed,
                    icon: const Icon(Icons.refresh_outlined),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFe64e3e),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$totalPomodoros/4',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'ROUND',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$totalGoal/12',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'GOAL',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
