import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_todoapp/data/user/result_api.dart';
import 'package:hive_todoapp/data/user/user.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ListUser extends StatefulWidget {
  ListUser({Key? key}) : super(key: key);

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  @override
  void initState() {
    super.initState();
  }

  Future<Response<Map<String, dynamic>>> getData() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(maxWidth: 300));
    Response<Map<String, dynamic>> response = await dio.get('https://reqres.in/api/users?page=2');
    Map<String, dynamic> map = response.data!;
    ResultApi resultApi = ResultApi.fromMap(map);
    List<User> datas = resultApi.user;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Response<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, AsyncSnapshot<Response<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Mohon tunggu'));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data == null || snapshot.data!.data == null) {
            return Center(child: Text('Null detected'));
          }
          Map<String, dynamic> map = snapshot.data!.data!;
          ResultApi resultApi = ResultApi.fromMap(map);
          List<User> datas = resultApi.user;
          return ListView.separated(
            itemBuilder: (context, index) {
              User data = datas[index];
              return ListTile(
                title: Text('${data.first_name} ${data.last_name}'),
                subtitle: Text(data.email),
              );
            },
            separatorBuilder: (context, indext) => Divider(),
            itemCount: datas.length,
          );
        },
      ),
    );
  }
}
