import 'package:emmorceapp/constants/constants.dart';
import 'package:http/http.dart'as http;
class ApiServices{
  postdata(data,apiurl)async {
    var fullurl = Apiconstants.baseurl + apiurl;
    return await http.post(Uri.parse(fullurl), body: data);
  }
  getdata(apiurl)async{
    var fullurl=Apiconstants.baseurl + apiurl;
    return await http.get(Uri.parse(fullurl));
  }
  putdata(data,apiurl)async{
    var fullurl=Apiconstants.baseurl + apiurl;
    return await http.put(Uri.parse(fullurl),body: data);
  }
  deletedata(apiurl)async{
    var fullurl=Apiconstants.baseurl + apiurl;
    return await http.delete(Uri.parse(fullurl));
  }
  postdata_accept(apiurl)async {
    var fullurl = Apiconstants.baseurl + apiurl;
    return await http.post(Uri.parse(fullurl));
  }
}