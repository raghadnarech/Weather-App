import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_api/custom_widgets/buttom_app_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_api/helpers/api_helper.dart';
import 'package:weather_api/models/position_opject.dart';
import 'package:weather_api/models/weather_info.dart';
import 'package:weather_api/screens/select_city_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherInfo weatherInfo = WeatherInfo.empty();

  bool isLoading = true;

  Future<WeatherInfo> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position.latitude);
    // print(position.longitude);

    PositionObject myPosition =
        PositionObject(position.latitude, position.longitude);
    weatherInfo = await ApiHelper.getWeatherForLocation(myPosition);
    print(weatherInfo.cityName);
    print(weatherInfo.temp);
    print(weatherInfo.status);
    print(weatherInfo.humidity);
    print(weatherInfo.pressure);
    print(weatherInfo.windSpeed);

    setState(() {
      isLoading = false;
    });
    return weatherInfo;
  }

  Future<WeatherInfo> checkPermissionAndGetLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return await getLocation();
    } else {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return await getLocation();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Location permission is required for this app")));
        return WeatherInfo.empty();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   showLoadingDialog();
    // });
    checkPermissionAndGetLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(weatherInfo.cityName!),
        leading: Icon(Icons.location_on),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isLoading = true;
                checkPermissionAndGetLocation();
              });
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              String? cityNmae = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectCity()),
              );
              if (cityNmae != null) {
                setState(() {
                  isLoading = true;
                });
                weatherInfo = await ApiHelper.getWeatherByCityName(cityName);
                 setState(() {
                  isLoading = true;
                });
              }
            },
            icon: Icon(Icons.location_city),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Image/m.jpg"), fit: BoxFit.cover)),
        child: isLoading
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 300),
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GradientText(
                                "${weatherInfo.temp!.toStringAsFixed(0)}\u00b0",
                                style: TextStyle(
                                  fontSize: 140,
                                ),
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                  Color(0xffb7e9f5),
                                  Color(0xffb7e9f5),
                                ],
                                gradientDirection: GradientDirection.ttb,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image(
                                  image: NetworkImage(
                                      weatherInfo.getWeatherIconURL()),
                                ),
                              ),
                              Text(
                                weatherInfo.status!,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xffd9f3ff)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Pressure",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            height: 60,
                                            child: Image.asset(
                                                "Image/pressure.png")),
                                        Text(
                                          weatherInfo.pressure.toString() +
                                              " atm",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Speed",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            height: 60,
                                            child:
                                                Image.asset("Image/speed.png")),
                                        Text(
                                          weatherInfo.windSpeed.toString() +
                                              " km/h",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                            height: 60,
                                            child: Image.asset(
                                                "Image/humidity.png")),
                                        Text(
                                          weatherInfo.humidity.toString() +
                                              " g/m3",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void showLoadingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text("Loading weather info"),
              ],
            ),
          );
        });
  }
}
