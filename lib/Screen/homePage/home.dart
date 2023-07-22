import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // Storing data in SharedPreferences
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      if (state.getLoginState == null) {
        return Stack(
          children: [
            Image.asset(Font.urlImage + 'background.png',
                fit: BoxFit.fill,
                height: Sizer.getHeight(context),
                width: Sizer.getWidth(context)),
            Scaffold(
                backgroundColor: Colors.transparent,
                key: _scaffoldKey,
                appBar: MyAppBar(_scaffoldKey, context, null),
                endDrawer: Code.DrawerNative(context, _scaffoldKey),
                body: Body(context)),
          ],
        );
      } else {
        return Stack(
          children: [
            Image.asset(Font.urlImage + 'background.png',
                fit: BoxFit.fill,
                height: Sizer.getHeight(context),
                width: Sizer.getWidth(context)),
            Scaffold(
                backgroundColor: Colors.transparent,
                key: _scaffoldKey,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Sizer.getHeight(context) / 8),
                  child: MyAppBar(
                      _scaffoldKey, context, state.getTokenState!.token),
                ),
                endDrawer: state.getLoginState!.isLogin == true
                    ? Code.DrawerNativeSeconde(
                        context, _scaffoldKey, state.getTokenState!.token!)
                    : Code.DrawerNative(context, _scaffoldKey),
                body: Body(context)),
          ],
        );
      }
    });
  }

  //Make Body
  Body(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Sizer.getHeight(context) / 20,
        ),
        //MyAppBar(context , ),
        Expanded(child: Image.asset(Font.urlImage + 'logo.png')),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                RouterNav.fluroRouter.navigateTo(context, RouteName.AllClinics);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Sizer.getWidth(context) / 5,
                    height: Sizer.getHeight(context) / 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Coloring.primary),
                    child: Image.asset(
                      Font.urlImage + 'clinicIcon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    "العيادات",
                    style: TextStyle(
                        color: Coloring.secondary,
                        fontFamily: Font.fontfamily,
                        fontSize: Sizer.getTextSize(context, 0.07)),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                RouterNav.fluroRouter.navigateTo(context, RouteName.AllDoctors);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Sizer.getWidth(context) / 5,
                    height: Sizer.getHeight(context) / 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Coloring.primary),
                    child: Image.asset(Font.urlImage + 'doctorIcon.png',
                        fit: BoxFit.fill),
                  ),
                  Text(
                    "الأطبّاء",
                    style: TextStyle(
                        color: Coloring.secondary,
                        fontFamily: Font.fontfamily,
                        fontSize: Sizer.getTextSize(context, 0.07)),
                  )
                ],
              ),
            )
          ],
        ))
      ],
    );
  }

  //Make AppBar
  MyAppBar(
    GlobalKey<ScaffoldState> _scaffoldkey,
    BuildContext context,
    String? token,
  ) {
    return Code.AppBarHome(_scaffoldkey, context, token);
  }
}
