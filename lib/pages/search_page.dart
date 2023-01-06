import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../helpers/helper_functions.dart';
import '../services/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String userName = "";
  String email = "";
  String address = "";
  int phoneNumber = 0;
  String imageUrl="";
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    gettingUserData();
    super.initState();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailSP().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameSP().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await HelperFunctions.getUserAddressSP().then((value) {
      setState(() {
        address = value!;
      });
    });
    await HelperFunctions.getUserPhoneSP().then((value) {
      setState(() {
        debugPrint("${value}");
        phoneNumber = value!;
        debugPrint("${phoneNumber}");
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            bestFruitShopRow(context, email, userName, address, phoneNumber),
            SizedBox(height: 20,),
            searchBar(context),
            SizedBox(height: 50,),
            Image.network("https://firebasestorage.googleapis.com/v0/b/shopping-app-3649f.appspot.com/o/melon.png?alt=media&token=f540608c-bc55-4462-a1c1-3734ba370596"),
            Center(
              child: IconButton(
                onPressed: ()async{
                  ImagePicker imagePicker=ImagePicker();
                  XFile? file=await imagePicker.pickImage(source: ImageSource.gallery);
                  debugPrint("${file?.path}");
                  debugPrint("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");

                  Reference referenceRoot=FirebaseStorage.instance.ref();
                  Reference referenceDirImages=referenceRoot.child('images');

                  Reference referenceImageToUpload=referenceDirImages.child('${file?.name}');
                  await referenceImageToUpload.putFile(File(file!.path));
                  imageUrl=await referenceImageToUpload.getDownloadURL();
                  // try{
                  //
                  // }catch(error){
                  //
                  // }

                },
                icon: Icon(Icons.camera_alt),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
