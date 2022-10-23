class WeatherInfo {
  String? cityName;
  double? temp;
  String? status;
  int? humidity;
  int? pressure;
  double? windSpeed;
  String? iconCode;

  WeatherInfo(
      {this.cityName,
      this.temp,
      this.status,
      this.humidity,
      this.pressure,
      this.windSpeed,
      this.iconCode});

  factory WeatherInfo.empty() {
    return WeatherInfo(
        cityName: "",
        temp: 0,
        status: "-",
        humidity: 0,
        pressure: 0,
        windSpeed: 0,
        iconCode: "01d");
  }

  String getWeatherIconURL() {
    return "http://openweathermap.org/img/wn/$iconCode.png";
  }

  factory WeatherInfo.fromJson(Map<String, dynamic> data) {
    return WeatherInfo(
      cityName: data["name"],
      temp: data["main"]["temp"],
      status: data["weather"][0]["main"],
      humidity: data["main"]["humidity"],
      pressure: data["main"]["pressure"],
      windSpeed: data["wind"]["speed"],
      iconCode: data["weather"][0]["icon"],
    );
  }
}
