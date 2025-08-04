import 'package:flutter/material.dart';
import 'package:weather_app/material/color.dart';
import 'package:weather_app/view/home/home.dart';

class loginPage extends StatefulWidget {
  final double lat;
  final double lon;
  const loginPage({super.key, required this.lat, required this.lon});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _isPasswordVisible = false;
  bool _isChecked = false;
  
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/bgHome.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25.0, 100, 25, 0),              
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/midrain.png',
                    width: 200,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: colors.whiteColor,
                    ),
                  ),
                  SizedBox(height: Height * 0.03),
                    TextFormField(
                      style: TextStyle(
                        color: colors.whiteColor,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colors.whiteColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: colors.whiteColor),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(color: colors.whiteColor),
                      ),
                      minLines: 1,
                      cursorColor: colors.whiteColor,
                    ),
                    SizedBox(height: Height * 0.02),
                    TextFormField(
                      style: TextStyle(color: colors.whiteColor),
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(fontSize: 15, color: colors.whiteColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colors.whiteColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colors.whiteColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(color: colors.whiteColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: colors.whiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      minLines: 1,
                      cursorColor: colors.whiteColor,
                    ),
                    SizedBox(height: Height * 0.01),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _isChecked,
                          checkColor: colors.whiteColor,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = !_isChecked;
                            });
                          },
                          side: BorderSide(color: colors.whiteColor),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Remember Me",
                            style: TextStyle(
                                color: colors.whiteColor, fontSize: 14),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: colors.whiteColor, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: Height * 0.10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homePage(lat: widget.lat, lon: widget.lon,)));
                      },
                      
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(400, 50),
                        backgroundColor: colors.purpleColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: colors.whiteColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}