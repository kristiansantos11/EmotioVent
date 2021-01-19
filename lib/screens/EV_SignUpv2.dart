import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../database_classes/registerAccount.dart';

class EVSignUpv2 extends StatefulWidget {

  @override
  _EVSignUpv2State createState() => _EVSignUpv2State();
}

class _EVSignUpv2State extends State<EVSignUpv2> {

  final formKey = GlobalKey<FormState>();
  
  bool toggle1 = true;
  bool toggle2 = true;
  String email;
  String password;
  dynamic username;
  dynamic name;
  DateTime birthday;
  dynamic contactnum;
  dynamic gender;
  dynamic classHolder;
  String error = "";

  void register() async
  {
    if(formKey.currentState.validate() && birthday != null)
    {
      print("Validated successfully."); //debug
      print("Current Data: $email,$password,$username,$name,$birthday,$contactnum,$gender"); //debug
      print("Attempting to register email & password data to firebase..."); //debug
      classHolder = await RegisterAccount().register(email,password,username,name,birthday,contactnum,gender);
      print("$classHolder"); //debug - *must be null to be a success
      if(classHolder==null)
      {
        Navigator.pop(context, {});
      }
      else
      {
        setState(() {
          error = classHolder;
        });
      }
    }
    else
    {
      print("Not Validated"); //debug

    }
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  validator: (val) {
                    if(val=="")
                    {
                      return "Empty Email";
                    }
                    else
                    {
                      email = val;
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                  filled : true,
                  fillColor: Colors.white70,
                  hintText: "Email",
                  ),
                style: TextStyle(
                fontSize: 20
              ),
                ),
                Row( children: <Widget>[
                  Expanded(
                    child: TextFormField(
                    validator: (val) {
                      if(val=="")
                      {
                        return "Empty Password";
                      }
                      else
                      {
                        password = val;
                        return null;
                      }
                    },
                    obscureText: toggle1,
                    decoration: InputDecoration(
                    filled : true,
                    fillColor: Colors.white70,
                    hintText: "Password",
                    ),
                    style: TextStyle(
                    fontSize: 20
                  ),
                ),
                  ),
                  IconButton(
                  onPressed: () {
                    if(toggle1==true)
                    {
                      toggle1=false;
                    }
                    else{
                      toggle1=true;
                    }
                    setState(() {});
                  },
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.black,
                )
                ],),
                Row( children: <Widget>[
                  Expanded(
                    child: TextFormField(
                    validator: (val) {
                      if(val=="")
                      {
                        return "Empty Password";
                      }
                      if(val!=password)
                      {
                        return "Password do not match";
                      }
                      else
                      {
                        return null;
                      }
                    },
                    obscureText: toggle2,
                    decoration: InputDecoration(
                    filled : true,
                    fillColor: Colors.white70,
                    hintText: "Confirm Password",
                    ),
                    style: TextStyle(
                    fontSize: 20
                  ),
                ),
                  ),
                ],),
                TextFormField(
                  validator: (val) {
                    if(val=="")
                    {
                      return "Empty Username";
                    }
                    else
                    {
                      username = val;
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                  filled : true,
                  fillColor: Colors.white70,
                  hintText: "Username",
                  ),
                style: TextStyle(
                fontSize: 20
              ),
                ),
                TextFormField(
                  validator: (val) {
                    if(val=="")
                    {
                      return "Empty Name";
                    }
                    else
                    {
                      name = val;
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                  filled : true,
                  fillColor: Colors.white70,
                  hintText: "Name",
                  ),
                style: TextStyle(
                fontSize: 20
              ),
                ),
                SizedBox(height: 20),
                Text("Birthday",
                style: TextStyle(
                  fontSize: 20
                ),),
                DateField(
                  onDateSelected: (DateTime value) {
                    setState(() {
                      birthday = value;
                    });
                  }, 
                  selectedDate: birthday,),
                SizedBox(height: 10),
                TextFormField(
                  validator: (val) {
                    if(val == "")
                    {
                      return "Empty number!";
                    }
                    if(RegExp(r'^[0-9]*$').hasMatch(val)&&RegExp(r'$[0-9]\d{10}$|^[0-9]\d{10}$').hasMatch(val))
                    {
                      contactnum = val;
                      return null;
                    }
                    else{
                      return "Input a valid number!";
                    }
                  },
                  decoration: InputDecoration(
                  filled : true,
                  fillColor: Colors.white70,
                  hintText: "Contact No.",
                  ),
                style: TextStyle(
                fontSize: 20
              ),
                ),
                TextFormField(
                  validator: (val) {
                    if(val=="")
                    {
                      return "Empty Gender";
                    }
                    else
                    {
                      gender = val;
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                  filled : true,
                  fillColor: Colors.white70,
                  hintText: "Gender",
                  ),
                style: TextStyle(
                fontSize: 20
              ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async{register();},
                    child: Text(
                      "Register (Click me :>)",
                      style: TextStyle(
                        fontSize: 20
                      ),),
                  )
                ),
                Center(
                  child: Text("$error",
                  style: TextStyle(
                    color: Colors.red
                  ),),
                )
              ],
            )
          ],
        ),
      )
    )
    );
  }
}