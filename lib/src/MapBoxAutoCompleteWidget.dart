part of flutter_mapbox_autocomplete;

class MapBoxAutoCompleteWidget extends StatefulWidget {
  /// Mapbox API_TOKEN
  final String apiKey;

  /// Hint text to show to users
  final String hint;

  /// Callback on Select of autocomplete result
  final void Function(MapBoxPlace place) onSelect;

  /// if true will dismiss autocomplete widget once a result has been selected
  final bool closeOnSelect;

  /// The callback that is called when the user taps on the search icon.
  // final void Function(MapBoxPlaces place) onSearch;

  /// Language used for the autocompletion.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String language;

  /// The point around which you wish to retrieve place information.
  final Location location;

  /// Limits the no of predections it shows
  final int limit;

  ///Limits the search to the given country
  ///
  /// Check the full list of [supported countries](https://docs.mapbox.com/api/search/) for the MapBox API
  final String country;

  MapBoxAutoCompleteWidget({
    @required this.apiKey,
    this.hint,
    this.onSelect,
    this.closeOnSelect = true,
    this.language = "en",
    this.location,
    this.limit,
    this.country,
  });

  @override
  _MapBoxAutoCompleteWidgetState createState() =>
      _MapBoxAutoCompleteWidgetState();
}

class _MapBoxAutoCompleteWidgetState extends State<MapBoxAutoCompleteWidget> {
  final _searchFieldTextController = TextEditingController();
  final _searchFieldTextFocus = FocusNode();

  Predections _placePredictions = Predections.empty();

  Future<void> _getPlaces(String input) async {
    if (input.length > 0) {
      String url =
          "https://api.mapbox.com/geocoding/v5/mapbox.places/$input.json?access_token=${widget.apiKey}&cachebuster=1566806258853&autocomplete=true&language=${widget.language}&limit=${widget.limit}";
      if (widget.location != null) {
        url += "&proximity=${widget.location.lng}%2C${widget.location.lat}";
      }
      if (widget.country != null) {
        url += "&country=${widget.country}";
      }
      final response = await http.get(Uri.parse(url));
      // print(response.body);
      // // final json = jsonDecode(response.body);
      final predictions = Predections.fromRawJson(response.body);

      _placePredictions = null;

      setState(() {
        _placePredictions = predictions;
      });
    } else {
      setState(() => _placePredictions = Predections.empty());
    }
  }

  void _selectPlace(MapBoxPlace prediction) async {
    // Calls the `onSelected` callback
    widget.onSelect(prediction);
    if (widget.closeOnSelect) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          hintText: widget.hint,
          textController: _searchFieldTextController,
          onChanged: (input) => _getPlaces(input),
          focusNode: _searchFieldTextFocus,
          onFieldSubmitted: (value) => _searchFieldTextFocus.unfocus(),
          // onChanged: (input) => print(input),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _searchFieldTextController.clear(),
          )
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (cx, _) => Divider(),
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: _placePredictions.features.length,
        itemBuilder: (ctx, i) {
          MapBoxPlace _singlePlace = _placePredictions.features[i];
          return ListTile(
            title: Text(_singlePlace.text),
            subtitle: Text(_singlePlace.placeName),
            onTap: () => _selectPlace(_singlePlace),
          );
        },
      ),
    );
  }
}
