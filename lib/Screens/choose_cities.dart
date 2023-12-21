import 'package:flutter/material.dart';
import 'package:weather_api/model/ApiCall.dart';

List<String> item = ["Thanjavur"];

class ChooseCities extends StatefulWidget {
  const ChooseCities({super.key});

  @override
  State<ChooseCities> createState() => _ChooseCitiesState();
}

class _ChooseCitiesState extends State<ChooseCities> {
  TextEditingController _searchController = TextEditingController();
  String _suggestionList = "";
  bool _showSuggestions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Manage cities",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: TextField(
              controller: _searchController,
              showCursor: _showSuggestions ? true : false,
              onChanged: (text) async {
                _fetchCities(text);
              },
              onTap: () {
                setState(() {
                  _showSuggestions = true;
                });
              },
              onTapOutside: (outside) {
                setState(() {
                  _searchController = TextEditingController();
                });
              },
              decoration: InputDecoration(
                focusColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                hintText: "Enter Location",
                hintStyle: const TextStyle(
                  color: Colors.white38,
                  height: 0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                constraints: BoxConstraints.tight(const Size(350.0, 50.0)),
              ),
              style: const TextStyle(
                // fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _showSuggestions ? _buildSuggestions() : const SizedBox(),
          Expanded(
            child: ListView.builder(
              //padding: EdgeInsets.only(left: 6.0,right: 6.0),
              itemCount: item.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: ListTile(
                    // selected: isSelected,
                    onTap: () {
                      Navigator.pop(context, item[index]);
                    },
                    onLongPress: () {
                      setState(() {
                        item.removeAt(index);
                      });
                    },
                    title: Text(
                      item[index],
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    // subtitle: const Text(
                    //     "24°",
                    // ),
                    // trailing: const Text(
                    //     "24°",
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    leadingAndTrailingTextStyle: const TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    dense: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
      child: TextButton(
        onPressed: () {
          setState(() {
            _searchController.text = _suggestionList;
            _showSuggestions = false;
            item.add(_suggestionList);
            Navigator.pop(context, _suggestionList);
            //Home
          });
        },
        child: Text(_suggestionList),
      ),
    );
    // onTap: () {
    //   setState(() {
    //     _searchController.text = _suggestionList;
  }

  // @override
  // void dispose() {
  //   _searchController.dispose();
  //   super.dispose();
  // }

  void _fetchCities(String input) async {
    if (input.isEmpty) {
      setState(() {
        _suggestionList = "";
      });
      return null;
    }

    try {
      final result = await ApiCall().fetchWeather(input);
      setState(() {
        _suggestionList = result.location.name;
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
