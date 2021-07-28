import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabletop_scanner/models/game.dart';
import 'package:tabletop_scanner/models/rental.dart';
import 'package:tabletop_scanner/screens/game.dart';
import 'package:tabletop_scanner/screens/rental.dart';
import 'package:tabletop_scanner/utilities/constants.dart';
import 'package:tabletop_scanner/utilities/interactions.dart';
import 'package:tabletop_scanner/widgets/button_form_small.dart';
import 'package:tabletop_scanner/widgets/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabletop Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  List<Rental> _rentals = [];

  Future<void> loadRentals() async {
    setState(() {
      _isLoading = true;
    });

    Rental.loadAll().then((rentals) {
      setState(() {
        _rentals = rentals;
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadRentals();
  }

  Future<void> scanGameBarCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#000000', "Cancel", true, ScanMode.BARCODE);

    print('CODE READ:' + barcodeScanRes);

    Game? game = await Game.find(barcodeScanRes);
    if (game == null) {
      openScreen(
          GameScreen(game: Game(id: null, name: '', upc: barcodeScanRes)),
          context);
    } else {
      Rental? rental = await Rental.find(game.id!);
      if (rental == null) {
        openScreen(
            RentalScreen(
                rental: Rental(
                    id: null,
                    gameId: game.id!,
                    game: game,
                    userId: null,
                    start: DateTime.now(),
                    end: null)),
            context);
      } else {
        returnGame(rental);
      }
    }
  }

  void returnGame(Rental rental) async {
    rental.end = DateTime.now();
    rental.game = await Game.load(rental.gameId!);
    Rental.save(rental);
    loadRentals();
    toastSuccess(
        rental.game!.name + ' has been returned successfully', context);
  }

  Future<void> scanGame() async {
    // Are there accessible cameras?
    availableCameras().then((availableCameras) {
      var cameras = availableCameras;
      if (cameras.length > 0) {
        scanGameBarCode();
      } else {
        // No Cameras Available - Manually Enter
        openScreen(
            RentalScreen(
                rental: Rental(
                    id: null,
                    gameId: null,
                    userId: null,
                    start: DateTime.now(),
                    end: null)),
            context);
      }
    });
  }

  Widget rentalList() {
    if (_rentals.isEmpty) {
      return Center(
        child: Text("No current rentals."),
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _rentals.length,
              itemBuilder: (BuildContext context, int index) {
                final Rental rental = _rentals[index];
                return ExpansionTile(
                  title: Text(
                    rental.game?.name ?? "Name Missing",
                  ),
                  children: [
                    Text(rental.user?.name ?? ''),
                    Text(DateFormat(DATE_FORMAT_LONG).format(rental.start)),
                    const SizedBox(height: 5),
                    ButtonFormSmall(
                        buttonText: 'Return Game',
                        method: () => returnGame(rental)),
                    const SizedBox(height: 15)
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.grey),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Tabletop Scanner"),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () => openScreen(
                        RentalScreen(rental: Rental(start: DateTime.now())),
                        context,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 26.0,
                      ),
                    ))
              ],
            ),
            drawer: const MenuScreen(),
            body: Column(
              children: [
                Expanded(child: rentalList()),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {scanGame()},
              child: const FaIcon(FontAwesomeIcons.barcode),
              backgroundColor: Colors.black,
            )),
        isLoading: _isLoading,
        opacity: 0.8,
        progressIndicator: const CircularProgressIndicator());
  }
}
