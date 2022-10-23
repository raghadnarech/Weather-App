class Country {
  String? name;
  String? capital;
  String? flagUrl;

  Country(this.name, this.capital, this.flagUrl);
  static List<Country> fromJsonArray(List<dynamic> data) {
    List<Country> countries = [];
    data.forEach((element) {
      String name = element["name"]["common"];
      String capital = "";
      if (element["capital"] != null) {
        capital = element["capital"][0];
      }

      String flagUrl = element["flags"]["png"];
      Country country = Country(name, capital, flagUrl);
      countries.add(country);
    });
    return countries;
  }
}
