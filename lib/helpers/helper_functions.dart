
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userAddressKey ="USERADDRESSKEY";
  static String userPhoneKey = "USERPHONEKEY";

  static String productNameKey="PRODUCTNAMEKEY";
  static String productPriceKey="PRODUCTPRICEKEY";
  static String productImageKey="PRODUCTIMAGEKEY";

  //-------------------------------------------------------------------- Save User Data to SP
  static Future<bool> saveUserLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setBool(userLoggedInKey, isLoggedIn);
  }
  static Future<bool> saveUserNameSP(String name) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.setString(userNameKey, name);
  }
  static Future<bool> saveUserEmailSP(String email) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.setString(userEmailKey, email);
  }
  static Future<bool> saveUserAddressSP(String address) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.setString(userAddressKey, address);
  }
  static Future<bool> saveUserPhoneSP(int phone) async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.setInt(userPhoneKey, phone);
  }

  //--------------------------------------------------------------------- Get User Data from SP
  static Future<bool?> getUserLoggedInStatus() async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.getBool(userLoggedInKey);
  }
  static Future<String?> getUserEmailSP() async
  {
    SharedPreferences sp=await SharedPreferences.getInstance();
    return sp.getString(userEmailKey);
  }
  static Future<String?> getUserNameSP()  async{
    SharedPreferences sp= await SharedPreferences.getInstance();
    return sp.getString(userNameKey);
  }
  static Future<String?> getUserAddressSP()  async{
    SharedPreferences sp= await SharedPreferences.getInstance();
    return sp.getString(userAddressKey);
  }
  static Future<int?> getUserPhoneSP()  async{
    SharedPreferences sp= await SharedPreferences.getInstance();
    return sp.getInt(userPhoneKey);
  }
}
