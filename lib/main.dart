import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:my_flutter_app/Views/first_view.dart';
import 'package:my_flutter_app/Views/sign_up_view.dart';
import 'package:my_flutter_app/services/auth_service.dart';
import 'Views/navigation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/provider_widget.dart';
import 'Views/search_view.dart';
import 'package:my_flutter_app/Views/profile_view.dart';
import 'temp/locater.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Provider(
      auth: new AuthService(),
      child: (MaterialApp(
        title:"Saradar",
        theme: ThemeData(
          primaryColor: Colors.green
        ),
        //home:Home()
        home:HomeController(),
        routes: <String,WidgetBuilder>{
          '/home':(BuildContext context) => HomeController(),
          '/signUp':(BuildContext context) => SignUpView(authFormType: AuthFormType.SignUp),
          '/signIn':(BuildContext context) => SignUpView(authFormType: AuthFormType.SignIn),
          '/anonymousSignIn':(BuildContext context) => SignUpView(authFormType: AuthFormType.Anonymous),
          '/convertUser':(BuildContext context) => SignUpView(authFormType: AuthFormType.Convert,),
          '/searchView' :(BuildContext context ) => SearchView() ,
          '/profileView' :(BuildContext context ) =>ProfilePage(),
        },

      )),
    );
  }

}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder <String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot <String> snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            final bool SignedIn = snapshot.hasData;
            return SignedIn ? Home() : FirstView();
          }
          return CircularProgressIndicator();
      },
    );
  }
}






