import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(
                      "https://picsum.photos/200",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  ,
            ),

            Text("Đăng nhập",style: TextStyle(fontSize: 20),),
              Spacer(),

            Container(
              decoration: BoxDecoration(
               border: Border(bottom: BorderSide(color: Colors.white,width: 1),top: BorderSide(color: Colors.white,width: 1),)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("About",style: TextStyle(fontSize: 20),),
                ],
              )),
               Container(
              decoration: BoxDecoration(
               border: Border(bottom: BorderSide(color: Colors.white,width: 1),)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Policy",style: TextStyle(fontSize: 20),),
                ],
              )),
            Padding(
              padding: const EdgeInsets.only(top:30, bottom:30),
              child: Text("Version: ",style: TextStyle(fontSize: 14),),
            ),
          ],
        ),
      ),
    );
  }
}