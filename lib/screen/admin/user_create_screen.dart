

import 'package:flutter/material.dart';
import 'package:flutter_mobile_barcode_qrcode_scanner/data_validations/login_validation.dart';
import '/style_varible/style_screen.dart';
import '/widget/button_widget.dart';
import '/database/auth_file.dart';
class UserCreate extends StatefulWidget {
  const UserCreate({super.key});

  @override
  State<UserCreate> createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  String _nameFrist='';
  String _nameLast='';
  String _email='';
  String _pass='';
  String _comfromPass='';

  //input fild ..............................
  Widget inputFild( double width,double heghit,String name,bool visible,Function validate,Function saved){
    return SizedBox(
      width: width,
      child: TextFormField(
        obscuringCharacter: '*',
        obscureText:visible,
        style: const TextStyle(fontFamily: fontRaleway,fontSize: 16,color: Colors.green),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(fontFamily: fontRaleway,fontSize: 14),
          errorStyle: const TextStyle(
            fontFamily:fontRaleway,
          ),

          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          // Add additional styling here if needed
        ),
        validator: (value) => validate(value),
        onSaved: (text)=>saved(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize =MediaQuery.of(context).size;
    double width=screenSize.width;
    double heghit=screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPlate2,
        title: const Text(
          "user Create",
          style: TextStyle(
            color: Colors.white,
            fontFamily: fontRaleway
          ),
        ),
      ),
      body:Container(
        padding: const EdgeInsets.all(15),
        child:  Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                  Image.asset('assets/images/add-user.png',width: 150,height: 150,),
                 Container(
                   margin: EdgeInsets.only(top: heghit/30),
                   child: Row(
                       children: [
                         inputFild(
                             width/2.4, 70, "First Name",false,
                                 (value){
                               if(value.toString().isEmpty){
                                 return "Frist Name is Empty";
                               }
                               return null;
                             },
                                 (text){
                               setState(() {
                                 _nameFrist=text.toString();
                               });
                             }
                         ),
                           SizedBox(width: width/12,),
                         //........................
                         inputFild(
                             width/2.4, 70, "Last Name",false,
                                 (value){
                               if(value.toString().isEmpty){
                                 return "Email is empty";
                               }
                               return null;
                             },
                                 (text){
                               setState(() {
                                 _nameLast=text.toString();
                               });
                             }
                         ),
                       ],
                     ),
                 ),
                const SizedBox(height: 30,),
                inputFild(
                    width, 70, "Email",false,
                        (value){
                      RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if(value.toString().isEmpty){
                        return "Frist Name is Empty";
                      }
                      if(!regex.hasMatch(value.toString())){
                        return "email pattern is not match";
                      }
                      return null;
                    },
                        (text){
                      setState(() {
                        _email=text.toString();
                      });
                    }
                ),
            
                const SizedBox(height: 30,),
                inputFild(
                    width, 70, "Enter your password",true,
                        (value){
                      RegExp specialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
                      if(value.toString().isEmpty){
                        return " password is Empty";
                      }
                      if(value.toString().length<5){
                         return "password should be morthan 5 character";
                      }
                      if (!specialChar.hasMatch(value.toString())) {
                        return "password should has special character";
                      }
                            setState(() {
                              _pass=value.toString();
                            });
                        return null;
                      },
                        (text){
                        setState(() {
                          _pass=text.toString();
                        });
                    }
                ),
            
                const SizedBox(height: 30,),
                inputFild(
                    width, 70, "Comfrome your password",true,
                        (value){
                      if(value.toString().isEmpty){
                        return " password is Empty";
                      }
                      if(value.toString()!=_pass){
                        return "password is not match";
                      }
                      return null;
                    },
                        (text){
                      setState(() {
                        _comfromPass=text.toString();
                      });
                    }
                ),
            
               SizedBox(height: heghit/45,),
            
                ButtonWidget(ctx: context,
                    buttonName:"Create Account",
                    buttonFontSize: 16,
                    buttonColor:colorPlate2,
                    borderColor: colorPlate3,
                    textColor:Colors.white,
                    buttonWidth:200,
                    buttonHeight:50,
                    buttonRadius:8,
                    validationStates:()async{
                        if(_formKey.currentState!.validate()){
                           _formKey.currentState!.save();
                           var result= await AuthService().signUpWithEmailAndPassword(
                               _nameFrist,
                               _nameLast,
                               _email,
                               _comfromPass
                           );
                           if(result.isNotEmpty){
                               setState(() {
                                 showError(
                                     context,
                                     "succsesful create user",
                                     "User Create",
                                     Icons.credit_score, Colors.green,
                                     Colors.white,
                                     Colors.white
                                 );
                                 //navigate page
                                 Navigator.pop(context);
                               });

                           }else{
                             setState(() {
                               showError(
                                   context,
                                   "user is not create",
                                   "User Create",
                                   Icons.credit_score, Colors.red,
                                   Colors.white,
                                   Colors.white
                               );
                             });
                           }

                        }
                    })
            
              ],
            ),
          ),
        ),

      ),
    );
  }
}
