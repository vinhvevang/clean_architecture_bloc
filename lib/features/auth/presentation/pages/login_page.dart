import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
 LoginPage({super.key});


TextEditingController tax = TextEditingController();
TextEditingController userName = TextEditingController();
TextEditingController passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: tax,
              decoration: InputDecoration(
                label: Text("Ma so thue"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  
                  )
              ),
            ),
             TextFormField(
              controller: userName,
              decoration: InputDecoration(
                label: Text("ten dang nhap"),

              ),
             ),
              TextFormField(
                controller: passWord,
              decoration: InputDecoration(
                label: Text("Mat khau"),

              ),
              ),
          ],
        ),
    );
  }
}