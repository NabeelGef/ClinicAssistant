import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/blocShared/sharedBloc.dart';
import 'package:clinicassistant/blocShared/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBook extends StatefulWidget {
  const MyBook({super.key});

  @override
  State<MyBook> createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      if (state.getLoginState == null) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Coloring.third2,
            key: _scaffoldkey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(120.sp),
                child: Code.AppBarWithText(
                    _scaffoldkey, context, 'حجوزاتي ', true)),
            endDrawer: Code.DrawerNative(context, _scaffoldkey),
            body: BodyMyBook(),
          ),
        );
      } else {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Coloring.third2,
            key: _scaffoldkey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(120.sp),
                child: Code.AppBarWithText(
                    _scaffoldkey, context, 'حجوزاتي', true)),
            endDrawer: state.getLoginState!.isLogin == true
                ? Code.DrawerNativeSeconde(context, _scaffoldkey)
                : Code.DrawerNative(context, _scaffoldkey),
            body: BodyMyBook(),
          ),
        );
      }
    });
  }

  BodyMyBook() {
    return TabBarView(
      children: [futureBook(), previousBook()],
    );
  }

  futureBook() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset("${Font.urlImage}doctoravatar.png"),
                  ),
                  Column(
                    children: [
                      Text("الطبيب عيسى محمود",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getWidth(context) / 15,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                      Text("اختصاص : اسنان - تقويم",
                          style: TextStyle(
                              color: Coloring.primary,
                              fontSize: Sizer.getWidth(context) / 25,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Icon(Icons.info_outline_rounded,
                      color: Coloring.primary2, size: 25.sp)
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox();
          },
          itemCount: 3),
    );
  }

  previousBook() {}
}
