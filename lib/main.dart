import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/home.dart';
import 'api.dart';
// import 'package:mssql_connection/mssql_connection.dart';

void main() => runApp(const MaterialApp(
  home: Main(),
  debugShowCheckedModeBanner: false,
));


class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class   _MainState extends State<Main> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final formKey= GlobalKey<FormState>();
  // bool _isLoading=false;

  Future<Map<String,dynamic>> _login() async {
    // if (formKey.currentState!.validate()) {
    // MssqlConnection mssqlConnection = MssqlConnection.getInstance();
    // bool isConnected = await mssqlConnection.connect(
    //   ip: '160.0.0.3',
    //   port: '90',
    //   databaseName: 'SMPDATA',
    //   username: 'sa',
    //   password: 'vectra',
    //   timeoutInSeconds: 15,
    // );
    // print("print the connection $isConnected.toString()");
      String username = _usernameController.text;
      String password = _passwordController.text;

      Map<String,dynamic> response=await Api.loginUser(username, password);

      return response;
  }

  void _showError(String message)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
      duration: const Duration(seconds: 3),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[800],
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Image(
                      image: AssetImage('lib/images/AMNS_Logo_Mid.jpg'),
                      width: 70,
                      height: 60,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Text(
                        'Ladle Management',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Username',
                        hintText: "Domain Username(Alias)",
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.person),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is empty";
                        } else if (value.length < 6) {
                          return "Username is too short";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is empty";
                        } else if (value.length < 6) {
                          return "Password is too short";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Password',
                        hintText: "Please Enter Your Password",
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.lock),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () async {
                            String username = _usernameController.text;

                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Home(username: username),
                              ),
                            );
                            // if (formKey.currentState!.validate()) {
                            //   Map<String, dynamic> response = await _login();
                            //   print("---------------------------------------------");
                            //   print(response.runtimeType);
                            //   print(response);
                            //
                            //   if (response["success"] == true) {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => Home(username: username),
                            //       ),
                            //     );
                            //   } else {
                            //     print("Some Error Occurred $response");
                            //   }
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                          child: const Text('Login into the Portal'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}