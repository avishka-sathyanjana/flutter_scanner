import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '/screen/admin/admin_dash_bord.dart';
import 'qr_scanner.dart';
import '/style_varible/style_screen.dart';
import 'package:flutter/material.dart';
import '/widget/button_widget.dart';
import '/data_validations/login_validation.dart';
import '/database/auth_file.dart';
import '/screen/dash_bord_screen.dart';
import 'results_screen.dart';
import '/database/get_local_data.dart';
import '/database/genarate_excel.dart';

class MainScreen extends StatefulWidget {
  //final Function startTime;
  static const mainScreenPageRoute = "/main-screen";
  MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference collectionUser =
  FirebaseFirestore.instance.collection('User');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String email = ""; //get email value
  late String password = ""; //get password value

//logo and pages hedar view
  Widget logoView(BuildContext context, String image, String hed) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Center(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                image,
                height: 100,
                width: 100,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                hed,
                style: const TextStyle(
                    color: Colors.black, fontFamily: fontRaleway, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

// input filed widget
  Widget inputFiled(
      BuildContext context,
      String hinttext,
      IconData icon,
      bool hideText,
      double defirent,
      Function textValue,
      TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(top: defirent),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextField(
          obscureText: hideText,
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: Icon(
                icon,
                color: Colors.black12,
              ),
              contentPadding: const EdgeInsets.only(left: 20, top: 10),
              hintText: hinttext,
              // errorText: showError(),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
          onChanged: (value) => textValue(value)),
    );
  }

  // validation data
  void validateData(BuildContext context) async {
    if (!LoginValidation(email, password, context)) {
      User? user =
      await AuthService().signInWithEmailAndPassword(email, password);

      if (user != null) {
        var getUser =
        _db.collection('User').where('email', isEqualTo: user.email).get();
        getUser.then((value) {
          if (value.docs.isEmpty) {
            print('No documents found for the user with email: $email');
            return;
          }

          if (value.docs.length > 1) {
            // Handle case where multiple documents are found (shouldn't happen in your case)
            print('Multiple documents found for the user with email: $email');
            return;
          }

          var doc = value.docs.single;
          if (doc['type'].toString() == 'admin') {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AdminDsh()));
            _emailController.clear();
            _passwordController.clear();
            email = "";
            password = "";
          } else {
            setState(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const DashBord()));
              _emailController.clear();
              _passwordController.clear();
              email = "";
              password = "";
            });
          }
        });
      } else {
        setState(() {
          showError(context, "Email or password is invalid", "Error",
              Icons.error, colorPlate3, Colors.red, Colors.red);
        });
      }
    } else {
      throw () => Exception("error rec vest");
    }
  }

  //upload data to firebase ...................
  Future<void> uploadJson() async {
    String jsonConect = await rootBundle
        .loadString("assets/json_file/AssetListDBwithNoEmplty.json");
    List<dynamic> usersList = json.decode(jsonConect);

    print("length array myyyyyyyyyyyyyy${usersList.length}");

    for (var userData in usersList) {
      await AuthService().uploadUserDataFormJson(userData);
    }
    print("complete asing data bbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
  }

  //upload data location.....................

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPlate2,
          automaticallyImplyLeading: false,
          title: const Text(
            "Board Of Survey",
            style: TextStyle(
                color: Colors.white, fontFamily: fontRaleway, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            //color: colorPlate3,
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                logoView(
                    context, "assets/images/logoucsc.png", "Login"), //logo view
                // input filed function
                inputFiled(context, "Enter your Email", Icons.email_outlined,
                    false, 50, (value) {
                      setState(() {
                        email = value; // set user email to email variable
                      });
                    }, _emailController),
                // input filed function
                inputFiled(context, "Enter your Password",
                    Icons.content_paste_search, true, 25, (value) {
                      setState(() {
                        password = value; //set password password variable
                      });
                    }, _passwordController),
                //forget password sections
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: InkWell(
                    onTap: () {
                      //navigate to forget password filed, now is not works
                      // navigate the forget password page
                    },
                    child: const Text(
                      "Forget password?",
                      style: TextStyle(
                          fontFamily: fontRaleway,
                          fontSize: 18,
                          color: colorPlate2),
                    ),
                  ),
                ),
                //..............................
                ButtonWidget(
                  //make the usability button widget
                  ctx: context, //pass the context
                  buttonName: "Login", //button name args
                  buttonFontSize: 20,
                  buttonColor: Colors.blueAccent,
                  borderColor: Colors.blueAccent,
                  textColor: Colors.white,
                  buttonWidth: 150,
                  buttonHeight: 50,
                  buttonRadius: 10, //button heghit
                  validationStates: () =>
                      validateData(context), // call back function
                )
              ],
            ),
          ),
        ));
  }
}
