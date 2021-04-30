import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_flutter_app/services/auth_service.dart';
import'package:auto_size_text/auto_size_text.dart';
import 'package:my_flutter_app/widgets/provider_widget.dart';

final primaryColor=Colors.blue;
enum AuthFormType{
  SignIn,SignUp,Reset,Anonymous,Convert
}
class SignUpView extends StatefulWidget {
   AuthFormType authFormType;
  SignUpView({Key key ,@required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
   AuthFormType authFormType;
  _SignUpViewState({this.authFormType});
  final formKey = GlobalKey<FormState>();
  String _email,_password,_name,_warning;

  void switchFormState(String state){
  formKey.currentState.reset();
  if(state == "Sign Up"){
    setState(() {
      authFormType =AuthFormType.SignUp;
    });
  }
  else if(state == "home"){
  Navigator.of(context).pop();

  }
  else{
    setState(() {
      authFormType = AuthFormType.SignIn;
    });
  }
  }

  bool validate(){
    final  form =formKey.currentState;
    form.save(); ////////////////////check
    if(form.validate()){
      form.save();
      return true;
    }
    else
      return false;


  }

  void submit() async{
    if(validate()){
      try{
        final auth = Provider.of(context).auth;
        if(authFormType == AuthFormType.SignIn){
           await auth.signInWithEmailAndPassword(_email, _password);

          Navigator.of(context).pushReplacementNamed('/home');
        }
        else if(authFormType == AuthFormType.Reset){
          await auth.sendPasswordResetEmail(_email);
          _warning ="A Password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.SignIn;
          });
        }
        else{
          String uid = await auth.createUserWithEmailAndPassword(_email, _password, _name);
          print("signed In with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
      catch(e){
        setState(() {
          _warning=e.message;
        });
        print(e);
      }
    }

  }
  Future submitAnonymous() async{
    final auth = Provider.of(context).auth;
   await auth.signInAnonymously();
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final _width =  MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if(authFormType == AuthFormType.Anonymous){
      submitAnonymous();
      return Scaffold(
        backgroundColor: Colors.blue,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitDoubleBounce(color:Colors.white),
            Text("Loading..",style: TextStyle(color: Colors.white),)
          ],
        ),
      );
    }
    else{
      return Scaffold(
        body: Container(
          color: primaryColor,
          height:_height,
          width: _width,
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: _height*0.025,),
                showAlert(),
                buildHeaderText(),
                SizedBox(height: _height*0.025,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        children: buildInputs() + buildButtons()
                    ),
                  ),
                ),
       
              ],
            ),
          ),
        ),
      );
    }


  }

  AutoSizeText buildHeaderText() {
    String headerText;
    if(authFormType == AuthFormType.SignIn)
      headerText ="Sign In";
    else if(authFormType == AuthFormType.Reset)
      headerText ="Reset Password";
    else
      headerText="Create a New Account ";
    return AutoSizeText(
                headerText,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white
                ),
            );
  }

  List<Widget> buildInputs(){
    List<Widget> textFields = [];

    if(authFormType == AuthFormType.Reset) {
      textFields.add(
          TextFormField(
            validator: NameValdiator.validate,
            style: TextStyle(fontSize: 22.0),
            decoration: buildSignUpInputDecoration("Email"),
            onSaved: (value) => _email = value,
          )
      );
      textFields.add(SizedBox(height: 20.0,));
      return textFields;
    }

    if(authFormType == AuthFormType.SignUp) {
      textFields.add(
          TextFormField(
            validator: NameValdiator.validate,
            style: TextStyle(fontSize: 22.0),
            decoration: buildSignUpInputDecoration("Name"),
            onSaved: (value) => _name = value,
          )
      );
      textFields.add(SizedBox(height: 20.0,));
    }
    textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        )
    );
    textFields.add(SizedBox(height: 20.0,));
    textFields.add(
        TextFormField(
          validator: PasswordValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Password"),
          obscureText: true,
          onSaved: (value) => _password = value,
        )
    );
    textFields.add(SizedBox(height: 20.0,));



    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0)),
          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0)

        );
  }

  List<Widget> buildButtons(){
    String _switchButton , _newFormState , _submitButtonText;
    bool _showForgotPasswordButton =false;
    bool _showSocial = false;
    if(authFormType == AuthFormType.SignIn){
      _switchButton = "Create A New Account";
      _newFormState = "Sign Up";
      _submitButtonText = "Sign In";
      _showForgotPasswordButton = true;
      _showSocial = true;
    }
    else if(authFormType == AuthFormType.Reset){
      _switchButton ="Return to Sign In";
      _newFormState = "Sign In";
      _submitButtonText ="Submit";
    }
    else{
      _switchButton = "Have an Account ? Sign In";
      _newFormState = "Sign In";
      _submitButtonText = "Sign Up";

    }
    return [
      Container(
        width: MediaQuery.of(context).size.width*0.7,
        child: RaisedButton(
          child: Text(
              _submitButtonText,
            style: TextStyle(fontSize: 20.0 ,color: Colors.blue),
          ),
          color: Colors.white,

          onPressed: (){
            submit();
          },
        ),
      ),
      showForgotPasswordButton(_showForgotPasswordButton),
      FlatButton(
        child: Text(_switchButton, style:TextStyle(fontSize: 20.0 , color: Colors.white),),
        onPressed: (){
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocial),

    ];
  }

  Widget showAlert(){
    if(_warning !=null){
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
              ),
              
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                setState(() {
                  _warning =null;
                });
              },
            )
            
          ],
        ),
      );
    }
    else
     return SizedBox(height: 0,);
  }

  Widget showForgotPasswordButton(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Your Password ?",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.Reset;
          });
        },

      ),
      visible: visible,
    );
  }

  Widget buildSocialIcons(bool value){
    final _auth = Provider.of(context).auth;
    return Visibility(
      child: Column(
        children: [
          Divider(color: Colors.white,),
          SizedBox(height: 10,),
          GoogleSignInButton(
            onPressed: () async {
              try{
                await _auth.signInWithGoogle();
                Navigator.of(context).pushReplacementNamed('/home');
              }catch(e){
                setState(() {
                  _warning = e.message;
                });
              }

            },
          ),
        ],
      ),
      visible: value,
    );
  }

}
