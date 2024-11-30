import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import  'package:dailydo/auth/login.dart';
import  'package:dailydo/auth/register.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyCGi2mxsfAUkmB3dHScr0sp-T2bFT_sQVA",
        authDomain: "chat-9b102.firebaseapp.com",
        projectId: "chat-9b102",
        storageBucket: "chat-9b102.firebasestorage.app",
        messagingSenderId: "777084584414",
        appId: "1:777084584414:web:eea21dc9cf5101b95a9d4f"
      )
    );  
  }else {
    await Firebase.initializeApp();
  }
  runApp(DailyDo());
}

class DailyDo extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyDo',
      theme: ThemeData(
        primaryColor: Colors.yellow,
        colorScheme: ColorScheme.light(),
        textTheme: TextTheme(
          headlineMedium: TextStyle(fontSize:24.0, fontWeight:FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontSize:16.0, color: Colors.black),        
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),                  
        )
      ),
      themeMode: ThemeMode.light,

      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen()
      }
    ); 
  }
}