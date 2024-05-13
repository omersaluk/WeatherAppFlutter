import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_flutter/bloc/weather_bloc_bloc.dart';
import 'package:weather_app_flutter/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0.5 * kToolbarHeight, 30, 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 200,
                width: 600,
                decoration: const BoxDecoration(color: Colors.orange),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationHeader(),
                  Center(
                    child: weatherIcon(),
                  ),
                  Center(
                    child: _currentTemp(),
                  ),
                  Center(
                    child: _weatherStuation(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: _dateTimeInfo(),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          _extraInfo(),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationHeader() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return Text(
            '📍 ${state.weather.areaName}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _dateTimeInfo() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat("EEEE dd 𐤟")
                        .add_jm()
                        .format(state.weather.date!),
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.white),
                  ),
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget weatherIcon() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          int code = state.weather.weatherConditionCode!;
          switch (code) {
            case >= 200 && < 300:
              return Image.asset(
                'assets/1.png',
                scale: 2,
              );
            case >= 300 && < 400:
              return Image.asset(
                'assets/2.png',
                scale: 2,
              );
            case >= 500 && < 600:
              return Image.asset(
                'assets/3.png',
                scale: 2,
              );
            case >= 600 && < 700:
              return Image.asset(
                'assets/4.png',
                scale: 2,
              );
            case >= 700 && < 800:
              return Image.asset(
                'assets/5.png',
                scale: 2,
              );
            case == 800:
              return Image.asset(
                'assets/6.png',
                scale: 2,
              );
            case > 800 && <= 804:
              return Image.asset(
                'assets/7.png',
                scale: 2,
              );
            case > 200 && <= 300:
            default:
              return Image.asset(
                'assets/7.png',
                scale: 2,
              );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget _currentTemp() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return Text(
            "${state.weather.temperature!.celsius!.toStringAsFixed(0)}°C",
            style: const TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.w600),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _weatherStuation() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return Center(
            child: Text(
              state.weather.weatherMain!.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _extraInfo() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/13.png',
                        scale: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Max Temprature",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${state.weather.tempMax!.celsius!.toStringAsFixed(0)}° C",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Row(
                    children: [
                      Image.asset(
                        'assets/14.png',
                        scale: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Min Temprature",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${state.weather.tempMin!.celsius!.toStringAsFixed(0)}° C",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/9.png',
                        scale: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Wind Speed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${state.weather.windSpeed}m/s",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(25)),
                  Row(
                    children: [
                      Image.asset(
                        'assets/8.png',
                        scale: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Humidty",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${state.weather.humidity!.toStringAsFixed(0)}%",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/11.png',
                        scale: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sunrise",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            DateFormat()
                                .add_jm()
                                .format(state.weather.sunrise!),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(90, 50, 0, 0)),
                  Row(
                    children: [
                      Image.asset(
                        'assets/12.png',
                        scale: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sunset",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            DateFormat().add_jm().format(state.weather.date!),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
