import 'package:flutter/material.dart';
import 'package:weather_api/helpers/api_helper.dart';
import 'package:weather_api/models/country.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    String cityName = "";
    var _controller = TextEditingController();
    List<Country> countries = [];
    bool isLoading = true;

    Future getData() async {
      dynamic data = await ApiHelper.getAllCountry();
      setState(() {
        isLoading = false;
        countries = Country.fromJsonArray(data);
      });
    }

    @override
    void initState() {
      super.initState();
      getData();
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context, _controller.text);
                      },
                      icon: Icon(Icons.search)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(127),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: ((context, index) {
                        Country country = countries[index];
                        return Card(
                          child: ListTile(
                            onTap: (() {
                              Navigator.pop(context, country.capital);
                            }),
                            title: RichText(text: ),
                            subtitle: Text(country.capital!),
                            trailing: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(country.flagUrl!)),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }
}
