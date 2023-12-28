// import 'package:doctor_baby/view/auth/registration.dart';
// import 'package:doctor_baby/view/home.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Login extends StatefulWidget {
//   @override
//   State<Login> createState() => _Login();
// }
// class _Login extends State<Login> {
//   final email = TextEditingController();
//   final pwd = TextEditingController();

  
//   // late SharedPreferences preferences;
//   // late bool newuser;

//   // late String storedemail;
//   // late String storedpass;

//   @override
//   void initState() {
//     check_if_user_already_login();
//     super.initState();
//   }

//   void check_if_user_already_login() async{
//     preferences = await SharedPreferences.getInstance();

//     newuser = preferences.getBool('newuser') ?? true;
    
//     if(newuser == false){
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>RegPage()));
//     }
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.grey[300],
//         title: const Text("LOGIN PAGE",style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold)),
//       ),


//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Card(
//             child: Container(
//               padding: EdgeInsets.all(15),
//               // color: Colors.white30,
//               height: 500,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
              
//                 const SizedBox(height: 25),
              
//                 Text("Welcome User", style: TextStyle(color: Colors.blue, fontSize: 25),),
              
//                         const SizedBox(height: 25),  
              
//                         Text("Email",),
              
//                           SizedBox(height: 5),
              
//                           Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25)
//                               ),
//                               child: TextField(
//                                 controller: email,
//                                 style: TextStyle(color: Colors.grey[600]),
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5)
//                                   ),
//                                   isDense: true,
//                                   hintText: "Enter Email",
//                                   fillColor: Colors.green
//                                 ),
//                               ),
//                             ),
//                         const SizedBox(height: 25),  
              
//                         Text("Password",),
              
//                           SizedBox(height: 5),
              
//                           Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25)
//                               ),
//                               child: TextField(
//                                 controller: pwd,
//                                 style: TextStyle(color: Colors.grey[600]),
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5)
//                                   ),
//                                   isDense: true,
//                                   hintText: "Enter Password",
//                                   fillColor: Colors.green
//                                 ),
//                               ),
//                             ),
//                         const SizedBox(height: 25),  
              
//                   Padding(
//                     padding: const EdgeInsets.only(left: 35),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
//                     fixedSize: MaterialStateProperty.all(Size(250, 40)),
//                       ),
//                         onPressed: () async {
//                           preferences = await SharedPreferences.getInstance();
//                           String username = email.text;
//                           String password = pwd.text;
          
//                             setState(() {
//                             storedemail = preferences.getString('email')!;
//                             storedpass = preferences.getString('pass')!; 
//                           });
          
        
//                           if ((username != "" && username == storedemail) && (password != "" && password == storedpass)) {
//                             preferences.setString('uname', username);
//                             preferences.setString('pword', password);
//                             preferences.setBool('newuser', false);
        
//                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VaccineCalendar())); // Navigate to RegPage after successful login
//                           } else {
//                             Fluttertoast.showToast(
//                               msg: "Invalid Username or Password",
//                               toastLength: Toast.LENGTH_SHORT,
//                               gravity: ToastGravity.TOP,
//                               backgroundColor: Colors.cyan,
//                               textColor: Colors.white,
//                               fontSize: 16.0,
//                             );
//                           }
//                           email.text = "";
//                           pwd.text = "";
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: const Text("Login", style: TextStyle(color: Colors.white),),
//                         )),
//                   ),
        
//                   SizedBox(height: 20),
        
//                   Container(
//                     alignment: Alignment.center,
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Divider(
//                             color: Colors.grey,
//                             height: 1,          
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text("OR"),
//                         ),
//                         Expanded(
//                           child: Divider(
//                             color: Colors.grey, 
//                             height: 1,           
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
        
//                   SizedBox(height: 20,),
        
//                   Container(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(20),),
//                     child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                          Image.asset("assets/google.png",height: 25),
//                          SizedBox(width: 25),
//                          Text("Signin with Google", style: TextStyle(fontSize: 16),),
//                       ],
//                     ),),
        
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
  
// }






import 'package:doctor_baby/view/auth/registration.dart';
import 'package:doctor_baby/view/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


void main(){
  runApp(MaterialApp(home: Login(),));
}

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> _loginUser() async {
    const String apiUrl = 'http://10.0.2.2:8000/babyapp/authlogin/';

    String userEmail = email.text;
    String userPassword = password.text;

    if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'email': userEmail,
            'password': userPassword,
          },
        );

        if (response.statusCode == 200) {
          print('Login successful');
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) => VaccineCalendar())));
        } else {
          print('Failed to login: ${response.statusCode}');
        }
      } catch (e) {
        print('Exception during login: $e');
      }
    } else {
      print('Email and password are required');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
        
              SizedBox(height: 10,),
        
              Text("Sign in", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
              
              SizedBox(height: 90,),
        
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            "Hi, Welcome back",
                            style: TextStyle(color: Colors.blue, fontSize: 25),
                          ),
                          const SizedBox(height: 25),
                          Text("Email"),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              controller: email,
                              style: TextStyle(color: Colors.grey[600]),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                isDense: true,
                                hintText: "Enter Email",
                                fillColor: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text("Password"),
                          SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              controller: password,
                              obscureText: true,
                              style: TextStyle(color: Colors.grey[600]),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                isDense: true,
                                hintText: "Enter Password",
                                fillColor: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
              
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("By signing in, I accept the", style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 13, letterSpacing: 0.4)),
                            GestureDetector(
                              onTap: () => "",
                              child: Text(" Terms and Conditions", 
                                style: TextStyle(
                                  color: Colors.blue,
                                  letterSpacing: 0.4,
                                  fontSize: 13),),
                            )
                          ],
                        ),
              
                          const SizedBox(height: 20),
              
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
                                fixedSize: MaterialStateProperty.all(Size(250, 40)),
                              ),
                              onPressed: () {
                                _loginUser(); 
                              },
                              child: const Text("Login", style: TextStyle(color: Colors.white)),
                            ),
                          ),
              
                          SizedBox(height: 20),
                
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    height: 1,          
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("Or continue with", style: TextStyle(color: Colors.grey[600], fontSize: 13),),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey, 
                                    height: 1,           
                                  ),
                                ),
                              ],
                            ),
                          ),
                
                          SizedBox(height: 20,),
                
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/google.png",height: 25),
                            ],
                          ),
                          
                          SizedBox(height: 20,),
              
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account ?", 
                              style: TextStyle(
                                color: Colors.grey[700]
                              ),),
                              GestureDetector(
                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>RegPage(),)),
                                child: Text("Sign up",
                                style: TextStyle(color: Colors.blue),)),
                            ],
                          )
              
              
                        ],
                      ),
                    ),
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
