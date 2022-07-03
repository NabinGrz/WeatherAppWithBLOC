import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/bloc/weather-bloc.dart';
import 'package:weatherapp/bloc/weather-event.dart';
import 'package:weatherapp/bloc/weather-state.dart';
import 'package:weatherapp/model/weather-model.dart';
import 'package:weatherapp/screen/weather-detail-page.dart';
import 'package:weatherapp/utility/device-size.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? currentLocation;
  getCurrent() async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red, content: Text("Permission Denied")));
        Geolocator.requestPermission();
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        var placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        currentLocation = placemarks[0].locality;
        print(placemarks);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please enable your location")));
    }

    BlocProvider.of<WeatherBloc>(context)
        .add(WeatherFetchEvent(currentLocation!));
  }

  @override
  void initState() {
    getCurrent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD WIDEGT");
    final WeatherModel weather;
    TextEditingController cityController = TextEditingController();
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: getDeviceHeight(context) / 2,
              width: getDeviceWidth(context),
              child: Lottie.asset('image/daynight.json'),
            ),
            Container(
              height: getDeviceHeight(context) / 10,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherErrorState) {
                        return Text(
                          state.errorMessage,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(255, 244, 7, 7)
                                  .withOpacity(.9)),
                        );
                      } else {
                        return const Text("");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 0,
                          color: Colors.grey.withOpacity(.1)),
                    ]),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: cityController,
                            onChanged: (value) {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(WeatherFetchEvent(cityController.text));
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              hintText: 'Enter location name',
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(.75)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: secondaryColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: errorColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<WeatherBloc, WeatherState>(
                          builder: (context, state) {
                            return IconButton(
                                onPressed: () async {
                                  log(state.toString());
                                  if (state is WeatherLoadedState) {
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                    Navigator.push(context, CupertinoPageRoute(
                                      builder: (context) {
                                        return BlocProvider(
                                          create: (context) => WeatherBloc(),
                                          child: WeatherDetail(
                                              weather: state.weather),
                                        );
                                      },
                                    ));
                                  }
                                },
                                icon: const Icon(Icons.location_on));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                            colors: [primaryColor, secondaryColor])),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          alignment: Alignment.center,
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  right: 75, left: 75, top: 15, bottom: 15)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          )),
                      onPressed: () async {
                        BlocProvider.of<WeatherBloc>(context)
                            .add(WeatherFetchEvent(cityController.text));
                        log(state.toString());
                        if (state is WeatherLoadedState) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          Navigator.push(context, CupertinoPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => WeatherBloc(),
                                child: WeatherDetail(weather: state.weather),
                              );
                            },
                          ));
                        } else if (state is WeatherNotFoundState) {
                          Navigator.push(context, CupertinoPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => WeatherBloc(),
                                child: WeatherDetail(weather: null),
                              );
                            },
                          ));
                        }
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(color: accentColor, fontSize: 16),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
