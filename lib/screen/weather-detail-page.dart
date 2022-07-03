import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather-model.dart';
import 'package:weatherapp/utility/colors.dart';
import 'package:weatherapp/utility/device-size.dart';

class WeatherDetail extends StatelessWidget {
  WeatherModel? weather;
  WeatherDetail({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: weather != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: getDeviceHeight(context) / 6,
                    width: getDeviceWidth(context),
                    color: backgroundColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                CupertinoIcons.arrow_left,
                                color: locationNowColor,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.gps_fixed,
                                color: locationNowColor,
                              ),
                              Text(
                                "Your Selected Location Now",
                                style: TextStyle(
                                    color: locationNowColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            weather!.name!,
                            style: TextStyle(
                                color: locationTextColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getDeviceHeight(context) / 1.8,
                    width: getDeviceWidth(context),
                    //color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: getDeviceHeight(context) / 2.9,
                            width: getDeviceWidth(context) / 1.28,
                            //   color: Colors.blue,
                            child: Image.asset(
                              //rain
                              (weather!.weather![0].main
                                          .toString()
                                          .toLowerCase() ==
                                      "clouds")
                                  ? "image/cloudy.png"
                                  : (weather!.weather![0].main
                                              .toString()
                                              .toLowerCase() ==
                                          "rain")
                                      ? "image/rainy.png"
                                      : (weather!.weather![0].main
                                                  .toString()
                                                  .toLowerCase() ==
                                              "haze")
                                          ? "image/haze.png"
                                          : "image/clear.png",
                              fit: BoxFit.cover,
                            )),
                        Container(
                          height: getDeviceHeight(context) / 18,
                          width: getDeviceWidth(context) / 4.5,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 237, 220, 219),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              weather!.weather![0].main.toString(),
                              style: TextStyle(
                                  color: locationTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Text(
                          "${(weather!.main!.tempMin!.round() - 273.15).toStringAsFixed(2)}°C",
                          style: TextStyle(
                              color: locationTextColor,
                              fontSize: 80,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //color: const Color.fromARGB(255, 237, 220, 219),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 188, 188, 188),
                                  offset: Offset(2.2, 2.3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud,
                              color: iconColors,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${(weather!.main!.tempMin!.round() - 273.15).toStringAsFixed(1)}°C",
                              style: TextStyle(
                                  color: iconColors,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   weather!.clouds!.all!.toString(),
                            //   style: const TextStyle(color: Colors.red, fontSize: 30),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //color: const Color.fromARGB(255, 237, 220, 219),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 188, 188, 188),
                                  offset: Offset(2.2, 2.3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: iconColors,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${weather!.main!.humidity}%",
                              style: TextStyle(
                                  color: iconColors,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //color: const Color.fromARGB(255, 237, 220, 219),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 188, 188, 188),
                                  offset: Offset(2.2, 2.3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wind_power,
                              color: iconColors,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${weather!.wind!.speed!}km/h",
                              style: TextStyle(
                                  color: iconColors,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //color: const Color.fromARGB(255, 237, 220, 219),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  color: Color.fromARGB(255, 188, 188, 188),
                                  offset: Offset(2.2, 2.3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.wind_snow,
                              color: iconColors,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${weather!.main!.pressure!}",
                              style: TextStyle(
                                  color: iconColors,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not Found!!",
                      style: TextStyle(
                          color: locationTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Try Again",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  ],
                ),
              ));
  }
}
