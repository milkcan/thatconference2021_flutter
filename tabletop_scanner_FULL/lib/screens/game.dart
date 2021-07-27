import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabletop_scanner/models/game.dart';
import 'package:tabletop_scanner/screens/games.dart';
import 'package:tabletop_scanner/utilities/interactions.dart';
import 'package:tabletop_scanner/utilities/validations.dart';
import 'package:tabletop_scanner/widgets/button_form_large.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key, required this.game}) : super(key: key);

  final Game game;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _key = GlobalKey<FormState>();
  final _title = "Game";
  bool _isSaving = false;
  bool _camerasAvailable = false;

  void cameraIsAvailable() {
    availableCameras().then((availableCameras) {
      var cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          _camerasAvailable = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cameraIsAvailable();
  }

  Future<void> scanGameBarCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#000000', "Cancel", true, ScanMode.BARCODE);

    print('CODE READ:' + barcodeScanRes);

    widget.game.upc = barcodeScanRes;
  }

  Future<void> save(BuildContext context) async {
    if (_key.currentState!.validate()) {
      try {
        setState(() {
          _isSaving = true;
        });

        await Game.save(widget.game);

        setState(() {
          _isSaving = false;
          openScreen(GamesScreen(), context);
        });
      } catch (e) {
        toastError('An error has occurred. ERROR: ' + e.toString(), context);
        print(e);
      } finally {
        setState(() {
          this._isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        child: Scaffold(
            appBar: AppBar(
              title: Text(_title),
            ),
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            labelText: '*Name',
                          ),
                          initialValue: widget.game.name,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: validateRequiredText,
                          onChanged: (String val) => widget.game.name = val),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            labelText: '*UPC',
                          ),
                          autocorrect: false,
                          initialValue: widget.game.upc,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          validator: validateRequiredText,
                          onChanged: (String val) => widget.game.upc = val),
                      const SizedBox(
                        height: 10,
                      ),
                      if (_camerasAvailable)
                        ButtonFormLarge(
                          buttonText: "Scan Barcode",
                          method: () => scanGameBarCode(),
                          status: true,
                          reverseColors: true,
                        ),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonFormLarge(
                          buttonText: "Save", method: () => save(context))
                    ])),
              ),
            )),
        isLoading: _isSaving,
        opacity: 0.8,
        progressIndicator: const CircularProgressIndicator());
  }
}
