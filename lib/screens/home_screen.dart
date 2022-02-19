import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:weather_app_v2/apiManger/models/current_weather.dart';
import 'package:weather_app_v2/apiManger/models/main.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:weather_app_v2/apiManger/models/weather.dart';
import 'package:weather_app_v2/apiManger/webService/api_web_service.dart';
import 'package:weather_app_v2/main.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextStyle txt1 = const TextStyle(
    color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold);

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final _dataservice = ApiWebService();
  final controller = TextEditingController();
  DateTime date = DateTime.now();
  String? city_name;
  String dateDayName = "";

  Widget _searchingWidget() {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: controller,
            autofocus: true,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Type a city name',
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              prefix: IconButton(
                onPressed: () {
                  getData(controller.text);
                  city_name = controller.text;
                  haveCity = true;
                  dateDayName =
                      DateFormat('MMM ,d EEEE ').format(date).toString();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              suffix: IconButton(
                onPressed: () {
                  setState(
                    () {
                      controller.clear();
                      _isSearching = false;
                      print(haveCity);
                    },
                  );
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // var weatherData_main = Main();
  CurrentWeather? weatherData;
  bool error = false;
  void getData(String city) async {
    final response = await _dataservice.getResponse(city);
    setState(() {
      weatherData = response;
      weatherData == null ? error = true : error = false;
    });
  }

  Widget _searchCity() {
    return _isSearching
        ? _searchingWidget()
        : Padding(
            // Todo responsive
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 15),
                  child: Text(
                    !error ? city_name ?? "" : "",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[600]),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        _isSearching = true;
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
          );
  }

  String weatherLotti(String wearther) {
    switch (wearther) {
      case "Windy":
        return "https://assets10.lottiefiles.com/private_files/lf30_dmgebz1e.json";
      case "Rainy ":
      case "Drizzle":
        return "https://assets3.lottiefiles.com/temp/lf20_rpC1Rd.json";
      case "Snow":
        return "https://assets3.lottiefiles.com/temp/lf20_WtPCZs.json";
      case "Stormy":
        return "https://assets3.lottiefiles.com/temp/lf20_XkF78Y.json";
      case "Fog":
        return "https://assets3.lottiefiles.com/temp/lf20_kOfPKE.json";
      case "Tornadoes":
        return "https://assets1.lottiefiles.com/packages/lf20_GZa0et.json";
      case "Clear":
        return "https://assets3.lottiefiles.com/temp/lf20_Stdaec.json";
      case "Clouds":
        return "https://assets3.lottiefiles.com/temp/lf20_VAmWRg.json";
      default:
        return "https://assets3.lottiefiles.com/temp/lf20_Stdaec.json";
    }
  }

  Widget buildWeatherwidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherData!.weather![0].main.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      dateDayName,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Text(
                      (weatherData!.main!.temp! - 273)
                              .toString()
                              .substring(0, 2) +
                          " C",
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Lottie.network(
                      weatherLotti(weatherData!.weather![0].main.toString()),
                      width: MediaQuery.of(context).size.width * 0.65,
                      // height: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWeatherwidget_withError() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Check your city name!",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ],
      ),
    );
  }

  bool haveCity = false;
  Widget online() {
    return Column(
      children: [
        _searchCity(),
        haveCity
            ? error
                ? buildWeatherwidget_withError()
                : buildWeatherwidget()
            : const Text(
                "Please enter a City Name",
                style: TextStyle(color: Colors.white),
              ),
      ],
    );
  }

  Widget no_internet_widget() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/noInternet.gif',
        ),
      ),
    );
  }

  Widget ShowloadingIndecator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return Stack(
                children: [
                  // Image.asset("assets/images/"),
                  online(),
                ],
              );
            } else {
              return no_internet_widget();
            }
          },
          child: ShowloadingIndecator(),
        ),
      ),
    );
  }
}
