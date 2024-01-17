
import 'package:flutter/material.dart';
import '/style_varible/style_screen.dart';


bool LoginValidation(String email, String password,BuildContext context){
   String emailError="";
   String passwordError="";
   String emailPattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9]+\.)+[a-zA-Z]{2,7}$';
   RegExp reg=RegExp(emailPattern);
     if(email.isEmpty){
         emailError="Email is Empty";
         showError(context, emailError,"Error");
         return true;
     }
     if(password.isEmpty){
       passwordError="Password is Empty";
       showError(context, passwordError,"Error");
       return true;
     }
     if(!reg.hasMatch(email)){
       emailError="email pattern is not match";
       showError(context, emailError,"Error");
       return true;
     }
     if(emailError.isEmpty&&passwordError.isEmpty){
       // showError("successful");
       return false;
     }
     return true;
  }

void showError(BuildContext context, String error,String errorHead) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        decoration:const BoxDecoration(
          color:colorPlate3,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child:Row(
          children: [
            const Icon(Icons.error_outline,size: 30,color: Colors.red,),
            const SizedBox(width: 15,),
            Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       Text(errorHead,style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red
                      ),
                      ),
                    const SizedBox(height: 10,),
                    Text(error,style: const TextStyle(
                      fontFamily: fontRaleway,
                      fontSize:12,
                      color: Colors.red,

                    ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
            )

          ],
        ),
      ),
      behavior:SnackBarBehavior.floating,
      elevation:0,
      backgroundColor:Colors.transparent,
      duration: const Duration(seconds: 2),
      // Adjust the duration as needed
    ),
  );
}
