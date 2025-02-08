import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CascadingAddressSelector(),
  ));
}

class CascadingAddressSelector extends StatefulWidget {
  @override
  _CascadingAddressSelectorState createState() => _CascadingAddressSelectorState();
}

class _CascadingAddressSelectorState extends State<CascadingAddressSelector> {
  String? selectedProvince;
  String? selectedCity;
  String? selectedDistrict;

  final Map<String, Map<String, List<String>>> addressData = {
    '广东省': {
      '广州市': ['天河区', '越秀区', '海珠区'],
      '深圳市': ['南山区', '福田区', '宝安区'],
    },
    '湖南省': {
      '长沙市': ['岳麓区', '芙蓉区', '天心区'],
      '株洲市': ['荷塘区', '石峰区', '芦淞区'],
    },
    // 可以继续添加更多省份、城市和区县
  };

  List<String> provinces = [];
  List<String> cities = [];
  List<String> districts = [];

  @override
  void initState() {
    super.initState();
    provinces = addressData.keys.toList();
  }

  void updateCities(String province) {
    setState(() {
      cities = addressData[province]?.keys.toList() ?? [];
      selectedCity = null; // Reset city selection when province changes
      districts = []; // Clear districts when province changes
      selectedDistrict = null; // Reset district selection when province changes
    });
  }

  void updateDistricts(String city) {
    setState(() {
      districts = addressData[selectedProvince]?[city] ?? [];
      selectedDistrict = null; // Reset district selection when city changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('省市区级联选择'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('请选择省份:'),
            DropdownButton<String>(
              value: selectedProvince,
              onChanged: (String? newValue) {
                setState(() {
                  selectedProvince = newValue;
                  updateCities(newValue!);
                });
              },
              items: provinces.map((String province) {
                return DropdownMenuItem<String>(
                  value: province,
                  child: Text(province),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('请选择城市:'),
            DropdownButton<String>(
              value: selectedCity,
              onChanged: selectedProvince == null
                  ? null
                  : (String? newValue) {
                      setState(() {
                        selectedCity = newValue;
                        updateDistricts(newValue!);
                      });
                    },
              items: cities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('请选择区县:'),
            DropdownButton<String>(
              value: selectedDistrict,
              onChanged: selectedCity == null
                  ? null
                  : (String? newValue) {
                      setState(() {
                        selectedDistrict = newValue;
                      });
                    },
              items: districts.map((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}