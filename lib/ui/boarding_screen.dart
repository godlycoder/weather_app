import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/home_bloc.dart';
import 'package:weather_app/model/WeatherResponse.dart';
import 'package:weather_app/ui/home_screen.dart';

class BoardingScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  HomeBloc _homeBloc;
  var isLoading = false;

  var name = TextEditingController();
  var zipCode = TextEditingController();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = true;
  String userName, email, mobile;

  @override
  void didChangeDependencies() {
    _homeBloc = HomeBloc();
    _homeBloc.initiate();
    _homeBloc.response.listen((value) {
      if (value != null && value?.error == null) {
        WeatherResponse response = value;
        response.name = name.text;
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(response: response)));
      }
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.teal,
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Container(),flex: 1),
              Expanded(
                child: Form(
                  key: _key,
                  autovalidate: _validate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RichText(
                          text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: 'Halo!'),
                                TextSpan(text: '\nCoba cari tahu cuaca di daerah mu',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      fontSize: 18,
                                    )
                                )
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 32,
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: name,
                          validator: validateName,
                          maxLength: 32,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Nama kamu',
                            hintStyle: TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            helperStyle: TextStyle(
                                color: Colors.white
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                            errorStyle: TextStyle(
                              color: Colors.white
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: validateKodePos,
                          style: TextStyle(color: Colors.white),
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Kode pos',
                            hintStyle: TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            errorStyle: TextStyle(
                                  color: Colors.white
                            )
                          ),
                          onChanged: (value) {
                            zipCode.text = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: StreamBuilder(
                            stream: _homeBloc.loading,
                            builder: (_, AsyncSnapshot<bool> snapshot) {
                              if (!snapshot.data) {
                                return Text('Submit',
                                  style: TextStyle(
                                      color: Colors.teal
                                  ),
                                );
                              }

                              return Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          onPressed: () {
                            _send(int.parse(zipCode.text));
                          },
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                flex: 3,
              ),
              Expanded(child: Container(
                height: 10,
                child: Center(
                  child: StreamBuilder(
                    stream: _homeBloc.response,
                    builder: (_, AsyncSnapshot<WeatherResponse> snapshot){
                      if(snapshot.data?.error != null) {
                        return Text('Kode pos tidak ditemukan',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300
                          ),
                        );
                      }
                      return Text('');
                    },
                  ),
                ),
              ), flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    debugPrint('ttt ${value == ''}');
    if (value.length == 0 || value == '') {
      return "Nama harus diisi";
    } else if (!regExp.hasMatch(value)) {
      return "Nama harus berisi a-z dan A-Z";
    }
    return null;
  }

  String validateKodePos(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0 && value.isEmpty) {
      return "Kode pos harus diisi";
    } else if(value.length != 5){
      return "Kode pos harus 5 digit";
    }else if (!regExp.hasMatch(value)) {
      return "Kode pos harus angka";
    }
    return null;
  }

  _send(int zipCode) {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      _homeBloc.getWeather(zipCode);
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

}