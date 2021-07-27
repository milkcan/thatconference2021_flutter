import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabletop_scanner/enums/id_type.dart';
import 'package:tabletop_scanner/main.dart';
import 'package:tabletop_scanner/models/game.dart';
import 'package:tabletop_scanner/models/rental.dart';
import 'package:tabletop_scanner/models/user.dart';
import 'package:tabletop_scanner/screens/game.dart';
import 'package:tabletop_scanner/screens/user.dart';
import 'package:tabletop_scanner/utilities/constants.dart';
import 'package:tabletop_scanner/utilities/interactions.dart';
import 'package:tabletop_scanner/widgets/button_form_large.dart';
import 'package:tabletop_scanner/widgets/button_icon.dart';

const textstyleFormLabel =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey);

const textstyleFormText =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);

class RentalScreen extends StatefulWidget {
  RentalScreen({Key? key, required this.rental}) : super(key: key);

  final Rental rental;

  @override
  _RentalScreenState createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  final _key = GlobalKey<FormState>();
  final _title = "Rental";
  bool _isSaving = false;
  List<Game> _games = [];
  List<User> _users = [];

  Future<void> loadData() async {
    setState(() {
      _isSaving = true;
    });

    _games = await Game.loadAll();
    _users = await User.loadAll();

    setState(() {
      _isSaving = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> save(BuildContext context) async {
    if (_key.currentState!.validate()) {
      try {
        setState(() {
          _isSaving = true;
        });

        await Rental.save(widget.rental);

        setState(() {
          _isSaving = false;
          openScreen(MyHomePage(), context);
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

  Widget chooseGames() {
    return DropdownButton(
      underline: SizedBox(),
      value: widget.rental.game,
      style: textstyleFormText,
      items: _games.map((Game game) {
        return new DropdownMenuItem<Game>(
          value: game,
          child: new Text(game.name),
        );
      }).toList(),
      onChanged: (Object? gameObject) {
        if (gameObject != null) {
          setState(() {
            Game game = gameObject as Game;
            widget.rental.gameId = game.id;
            widget.rental.game = game;
          });
        }
      },
    );
  }

  Widget chooseUsers() {
    return DropdownButton(
      underline: SizedBox(),
      value: widget.rental.user,
      style: textstyleFormText,
      items: _users.map((User user) {
        return new DropdownMenuItem<User>(
          value: user,
          child: new Text(user.name),
        );
      }).toList(),
      onChanged: (Object? userObject) {
        if (userObject != null) {
          setState(() {
            User user = userObject as User;
            widget.rental.userId = user.id;
            widget.rental.user = user;
          });
        }
      },
    );
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Renter',
                              style: textstyleFormLabel,
                            ),
                            chooseUsers(),
                            ButtonIcon(
                                icon: Icon(Icons.add),
                                method: () => {
                                      openScreen(
                                          UserScreen(
                                              user: User(
                                                  firstName: '',
                                                  lastName: '',
                                                  idType: IdType.DriversLicense,
                                                  idText: '')),
                                          context)
                                    }),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Game',
                              style: textstyleFormLabel,
                            ),
                            chooseGames(),
                            ButtonIcon(
                                icon: Icon(Icons.add),
                                method: () => {
                                      openScreen(
                                          GameScreen(
                                              game: Game(name: '', upc: '')),
                                          context)
                                    }),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: 'Start of Rental',
                        ),
                        initialValue: DateFormat(DATE_FORMAT_LONG)
                            .format(widget.rental.start),
                        readOnly: true,
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
