import 'package:emotiovent/services/EV_DatabaseService.dart';

class TransferUserData
{
  dynamic username;
  dynamic name;
  dynamic birthdate;
  dynamic contactNumber;
  dynamic gender;
  TransferUserData({this.username,this.name,this.birthdate,this.contactNumber,this.gender});
  
  Future<void> transferData() async
  {
    try 
    {
      dynamic userInfo = await DatabaseService().createData(username,name,birthdate,contactNumber,gender);
      if(userInfo!=null)
      {
        return "Complete!";
      }
      else
      {
        return "Error!";
      }
    } 
    catch (e) 
    {
      print("An error occured!"); // debug
      print("ERROR: $e"); // debug
    }
  }
}




