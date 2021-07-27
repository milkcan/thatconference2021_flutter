// import 'package:flutter/material.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:tabletop_scanner/enums/id_type.dart';
// import 'package:tabletop_scanner/models/user.dart';
// import 'package:tabletop_scanner/screens/users.dart';
// import 'package:tabletop_scanner/utilities/interactions.dart';
// import 'package:tabletop_scanner/utilities/validations.dart';
// import 'package:tabletop_scanner/widgets/button_form_large.dart';

// const textstyleFormLabel = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

// class UserScreen extends StatefulWidget {
//   UserScreen({Key? key, required this.user}) : super(key: key);

//   final User user;

//   @override
//   _UserScreenState createState() => _UserScreenState();
// }

// class _UserScreenState extends State<UserScreen> {
//   final _key = GlobalKey<FormState>();
//   final _title = "User";
//   bool _isSaving = false;

//   Future<void> save(BuildContext context) async {
//     if (_key.currentState!.validate()) {
//       try {
//         setState(() {
//           _isSaving = true;
//         });

//         await User.save(widget.user);

//         setState(() {
//           _isSaving = false;
//           openScreen(UsersScreen(), context);
//         });
//       } catch (e) {
//         toastError('An error has occurred. ERROR: ' + e.toString(), context);
//         print(e);
//       } finally {
//         setState(() {
//           this._isSaving = false;
//         });
//       }
//     }
//   }

//   Widget idType() {
//     return DropdownButton<IdType>(
//         value: widget.user.idType,
//         onChanged: (newValue) {
//           setState(() {
//             widget.user.idType = newValue!;
//           });
//         },
//         items: IdType.values.map((IdType classType) {
//           return DropdownMenuItem<IdType>(
//               value: classType, child: Text(classType.name));
//         }).toList());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LoadingOverlay(
//         child: Scaffold(
//             appBar: AppBar(
//               title: Text(_title),
//             ),
//             resizeToAvoidBottomInset: true,
//             body: SingleChildScrollView(
//               child: Form(
//                 key: _key,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(children: [
//                       TextFormField(
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)),
//                             labelText: '*First Name',
//                           ),
//                           initialValue: widget.user.firstName,
//                           textInputAction: TextInputAction.next,
//                           keyboardType: TextInputType.text,
//                           validator: validateRequiredText,
//                           onChanged: (String val) =>
//                               widget.user.firstName = val),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)),
//                             labelText: '*Last Name',
//                           ),
//                           initialValue: widget.user.lastName,
//                           textInputAction: TextInputAction.next,
//                           keyboardType: TextInputType.text,
//                           validator: validateRequiredText,
//                           onChanged: (String val) =>
//                               widget.user.lastName = val),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Default Location',
//                               style: textstyleFormLabel,
//                             ),
//                             idType(),
//                           ]),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey)),
//                             labelText: '*ID Information',
//                           ),
//                           initialValue: widget.user.idText,
//                           textInputAction: TextInputAction.done,
//                           keyboardType: TextInputType.text,
//                           validator: validateRequiredText,
//                           onChanged: (String val) => widget.user.idText = val),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       ButtonFormLarge(
//                           buttonText: "Save", method: () => save(context))
//                     ])),
//               ),
//             )),
//         isLoading: _isSaving,
//         opacity: 0.8,
//         progressIndicator: const CircularProgressIndicator());
//   }
// }
