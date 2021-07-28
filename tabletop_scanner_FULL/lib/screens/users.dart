import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tabletop_scanner/enums/id_type.dart';
import 'package:tabletop_scanner/models/user.dart';
import 'package:tabletop_scanner/screens/user.dart';
import 'package:tabletop_scanner/utilities/interactions.dart';
import 'package:tabletop_scanner/widgets/menu.dart';
import 'package:tabletop_scanner/widgets/user_item.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final String title = "Users";
  List<User> _users = [];
  bool _isLoading = true;

  Future<void> loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    User.loadAll().then((users) {
      setState(() {
        _users = users;
        _isLoading = false;
      });
    });
  }

  Future<void> deleteItem(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove this user?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    User.delete(_users[index].id!);
                    loadUsers();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: const MenuScreen(),
        body: LoadingOverlay(
          isLoading: _isLoading,
          opacity: 0.5,
          progressIndicator: const CircularProgressIndicator(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListView.separated(
                itemCount: _users.length,
                itemBuilder: (BuildContext context, int index) {
                  final User user = _users[index];
                  return GestureDetector(
                      child: UserItem(
                        user: user,
                        onDelete: () => deleteItem(context, index),
                      ),
                      onTap: () => openScreen(UserScreen(user: user), context));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(color: Colors.grey)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openScreen(
                UserScreen(
                    user: User(
                        id: null,
                        firstName: "",
                        lastName: "",
                        idType: IdType.ConferenceBadge,
                        idText: '')),
                context);
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ));
  }
}
