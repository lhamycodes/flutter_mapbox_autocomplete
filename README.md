# flutter_mapbox_autocomplete

A Flutter Package for MapBox Places autocomplete.

## Installation

Use the package manager [pub.dev](https://pub.dev/) to install **flutter_mapbox_autocomplete**.

```bash
dependencies:
  flutter_mapbox_autocomplete: ^1.0.3

and run flutter pub get
```
## Usage

```flutter
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MapBox AutoComplete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _startPointController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter MapBox AutoComplete example"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: CustomTextField(
          hintText: "Select starting point",
          textController: _startPointController,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapBoxAutoCompleteWidget(
                  apiKey: "Your MapBox token here",
                  hint: "Select starting point",
                  onSelect: (place) {
                    // TODO : Process the result gotten
                    _startPointController.text = place.placeName;
                  },
                  limit: 10,
                ),
              ),
            );
          },
          enabled: true,
        ),
      ),
    );
  }
}
```

## Screenshots
<p>
    <img src="https://raw.githubusercontent.com/lhamycodes/flutter_mapbox_autocomplete/master/screenshots/1.png" width="200px" height="auto" hspace="20"/>
    <img src="https://raw.githubusercontent.com/lhamycodes/flutter_mapbox_autocomplete/master/screenshots/2.png" width="200px" height="auto" hspace="20"/>
    <img src="https://raw.githubusercontent.com/lhamycodes/flutter_mapbox_autocomplete/master/screenshots/3.png" width="200px" height="auto" hspace="20"/>
</p>

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)