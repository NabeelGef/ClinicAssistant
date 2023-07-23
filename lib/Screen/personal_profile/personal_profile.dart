
import 'package:clinicassistant/Screen/personal_profile/bloc/bloc.dart';
import 'package:clinicassistant/Screen/personal_profile/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Constant/Route/routename.dart';
import '../../Constant/Route/router.dart';
import '../../Constant/code.dart';
import '../../Constant/color.dart';
import '../../Constant/font.dart';
import '../../Constant/sizer.dart';
import '../../blocShared/sharedBloc.dart';
import '../../blocShared/state.dart';
import '../../widgets/Connectivity/bloc.dart';
import '../../widgets/Connectivity/state.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({Key? key}) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      return BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, connect) {
            if (connect is ConnectivityInitial) { // في حالة بيتأكد من وجود الانترنت
              return Center(
                  child: CircularProgressIndicator(color: Coloring.primary));
            } else if (connect is NotConnectedState) {// في حالة  الانترنت غير موجود
              isLoading = false;
              if (state.getLoginState == null) {// عدم اتصال الانترنت مع عدم تسجيل الدخول
                return Scaffold(
                    backgroundColor: Coloring.third,
                    key: _scaffoldkey,
                    appBar: MyAppBar(),
                    endDrawer: Code.DrawerNative(context, _scaffoldkey),
                    body: Code.ConnectionWidget(context, false));
              }
              return Scaffold( // عد الاتصال مع عدم تسجيل الدخول أو معه
                  backgroundColor: Coloring.third,
                  key: _scaffoldkey,
                  appBar: MyAppBar(),
                  endDrawer: state.getLoginState!.isLogin == true
                      ? Code.DrawerNativeSeconde(context, _scaffoldkey)
                      : Code.DrawerNative(context, _scaffoldkey),
                  body: Code.ConnectionWidget(context, false));
            } else {// الاتصال ناجح وموجود
              if (!isLoading) {// الاتصال ناجح مع وجود تسجيل الدخول
                isLoading = true;
               /* doctorProfileDataBloc.add(LoadingProfile(widget.id));
                doctorProfileDataBloc
                    .add(GetEvaluate(token: widget.token, doctorId: widget.id));*/

                //my code to get the information is here

              }
              if (state.getLoginState == null) {//الاتصال ناجح مع عدم وجود تسجيل دخول
                return Scaffold(
                    backgroundColor: Coloring.third,
                    key: _scaffoldkey,
                    appBar: MyAppBar(),
                    endDrawer: Code.DrawerNative(context, _scaffoldkey),
                    body: bodyInformation(context, state));
              }
              return Scaffold(// الاتصال ناجح مع عدم وجود تسجيل دخول
                  backgroundColor: Coloring.third,
                  key: _scaffoldkey,
                  appBar: MyAppBar(),
                  endDrawer: state.getLoginState!.isLogin == true
                      ? Code.DrawerNativeSeconde(context, _scaffoldkey)
                      : Code.DrawerNative(context, _scaffoldkey),
                  body: bodyInformation(context, state));
            }
          });
    });
  }
  @override
  Widget bodyInformation(BuildContext context , SharedState sharedState) {
    return Container(
      child:Column()
          /*
      BlocBuilder<PersonalProfileBloc, SuccessPersonalProfileStates>(
          builder: (context, state) {
            if (state.profileDoctor == null) {
              if (state.error.isNotEmpty) {
                return Center(child: Text(state.error));
              } else {
                return Center(
                    child:
                    CircularProgressIndicator(color: Colors.orange));
              }
            } else {
              return Column(
                children: [
                  SizedBox(height: 25),

                ],
              );
            }
          }),

           */
    );
  }

  MyAppBar() {
    return Code.AppBarProfile(_scaffoldkey, context);
  }
}


