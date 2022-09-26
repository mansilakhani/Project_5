import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_scrapper_cvd_app/text_field.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences _shared;
  List<String> _countryList = [];
  late String _countryName,
      _countryFlag,
      _totalConfirmed,
      _totalDeaths,
      _totalRecovered,
      _newConfirmed,
      _newDeaths,
      _newRecovered,
      _updateDate;

  Future _getJsonData() async {
    var _response =
        await http.get(Uri.parse("https://api.covid19api.com/summary"));
    return jsonDecode(_response.body);
  }

  @override
  void initState() {
    super.initState();
    _initShared();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe7e7e7),
      appBar: AppBar(
        centerTitle: true,
        elevation: 8.0,
        backgroundColor: Colors.white70,
        title: const Text(
          'Covid-19',
          style: TextStyle(
              color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
        future: _getJsonData(),
        // future: APIHelper.apiHelper.getJsonData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final int countrySize = (snapshot.data['Countries']).length;

            for (int i = 0; i < countrySize; i++) {
              _countryList.add(snapshot.data['Countries'][i]['Country']);
            }

            for (int i = 0; i < countrySize; i++) {
              if (snapshot.data['Countries'][i]['Country'].toString() ==
                  _countryName) {
                _totalConfirmed =
                    snapshot.data['Countries'][i]['TotalConfirmed'].toString();
                _totalDeaths =
                    snapshot.data['Countries'][i]['TotalDeaths'].toString();
                _totalRecovered =
                    snapshot.data['Countries'][i]['TotalRecovered'].toString();
                _newConfirmed =
                    snapshot.data['Countries'][i]['NewConfirmed'].toString();
                _newDeaths =
                    snapshot.data['Countries'][i]['NewDeaths'].toString();
                _newRecovered =
                    snapshot.data['Countries'][i]['NewRecovered'].toString();

                _countryFlag = snapshot.data['Countries'][i]['CountryCode']
                    .toString()
                    .toLowerCase();

                _updateDate = snapshot.data['Countries'][i]['Date']
                    .toString()
                    .substring(0, 10);
              }
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      color: Colors.white70,
                      elevation: 5.0,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://flagcdn.com/56x42/$_countryFlag.png',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 60,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Text(
                              _countryName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Colors.white70,
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textField(
                            desc: 'Total Confirmed :',
                            value: _totalConfirmed,
                            color: const Color(0xff3498db),
                          ),
                          textField(
                              desc: 'Total Deaths :',
                              value: _totalDeaths,
                              color: const Color(0xffd72323)),
                          textField(
                              desc: 'Total Recovered :',
                              value: _totalRecovered,
                              color: const Color(0xff30e3ca)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Card(
                      color: Colors.white70,
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textField(
                            desc: 'New Confirmed :',
                            value: _newConfirmed,
                            color: const Color(0xff3498db),
                          ),
                          textField(
                            desc: 'New Deaths :',
                            value: _newDeaths,
                            color: const Color(0xffd72323),
                          ),
                          textField(
                            desc: 'New Recovered :',
                            value: _newRecovered,
                            color: const Color(0xff30e3ca),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 5.0,
                      color: Colors.black87,
                      indent: 15.0,
                      endIndent: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 3.0,
                        bottom: 3.0,
                      ),
                      child: Text(
                        'Last Update : $_updateDate',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          showMaterialScrollPicker(
              context: context,
              backgroundColor: Color(0xffe7e7e7),
              cancelText: 'Cancel',
              confirmText: 'Ok',
              title: 'Pick Your Country',
              items: _countryList,
              selectedItem: _countryName,
              onChanged: (value) {
                setState(() {
                  _countryName = value;
                  _setCountry(_countryName);
                });
              });
        },
      ),
    );
  }

  _initShared() async {
    _shared = await SharedPreferences.getInstance();
    if (_shared.getString('countryName') == null) {
      setState(() => _countryName = 'Afghanistan');
    } else {
      setState(() => _countryName = _shared.getString('countryName')!);
    }
  }

  _setCountry(String countryName) async {
    await _shared.setString('countryName', countryName);
  }
}
