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
              margin: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                  color: Coloring.third3,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35.sp,
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
                      Spacer(),
                      Icon(Icons.info_outline_rounded,
                          color: Coloring.primary2, size: 25.sp)
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Coloring.third5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Coloring.primary,
                              size: 25.sp,
                            ),
                            Text("الأحد 1 - حزيران",
                                style: TextStyle(
                                    color: Coloring.primary,
                                    fontSize: Sizer.getWidth(context) / 25,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      )),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Coloring.third5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Coloring.primary,
                              size: 25.sp,
                            ),
                            Text("11:30 - 11:45 ",
                                style: TextStyle(
                                    color: Coloring.primary,
                                    fontSize: Sizer.getWidth(context) / 25,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      )),
                      SizedBox(
                        width: 10.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Coloring.third5),
                        child: Row(
                          children: [
                            Image.asset(
                              "${Font.urlImage}clinicavatar.png",
                              width: 25.sp,
                              height: 25.sp,
                            ),
                            Text("عيادة السّلام",
                                style: TextStyle(
                                    color: Coloring.primary,
                                    fontSize: Sizer.getWidth(context) / 25,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      )),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Coloring.third5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Coloring.primary,
                              size: 25.sp,
                            ),
                            Text("المتبقي 5  ايام ",
                                style: TextStyle(
                                    color: Coloring.primary,
                                    fontSize: Sizer.getWidth(context) / 25,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      )),
                      SizedBox(
                        width: 10.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Sizer.getWidth(context) / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Coloring.primary),
                    child: Text("إلغاء",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizer.getWidth(context) / 25,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 10.sp,
                  )
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

  previousBook() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                      color: Coloring.third3,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35.sp,
                          child:
                              Image.asset("${Font.urlImage}doctoravatar.png"),
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
                                    fontWeight: FontWeight.bold)),
                            Text("عيادة السّلام",
                                style: TextStyle(
                                    color: Coloring.primary,
                                    fontSize: Sizer.getWidth(context) / 25,
                                    fontFamily: Font.fontfamily,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.info_outline_rounded,
                            color: Coloring.primary2, size: 25.sp)
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text("الموعد السّابق",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Coloring.primary,
                            fontSize: Sizer.getWidth(context) / 25,
                            fontFamily: Font.fontfamily,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Coloring.third5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Coloring.primary,
                                size: 25.sp,
                              ),
                              Text("الأحد 1 - حزيران",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontSize: Sizer.getWidth(context) / 25,
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Coloring.third5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Coloring.primary,
                                size: 25.sp,
                              ),
                              Text("11:30 - 11:45 ",
                                  style: TextStyle(
                                      color: Coloring.primary,
                                      fontSize: Sizer.getWidth(context) / 25,
                                      fontFamily: Font.fontfamily,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                        SizedBox(
                          width: 10.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: Sizer.getWidth(context) / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Coloring.primary),
                      child: Text("تمت المعاينة ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizer.getWidth(context) / 25,
                              fontFamily: Font.fontfamily,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10.sp,
                    )
                  ]));
            },
            separatorBuilder: (context, index) {
              return SizedBox();
            },
            itemCount: 3));
  }
}
