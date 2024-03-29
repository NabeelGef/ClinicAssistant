// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinicassistant/Constant/Route/routename.dart';
import 'package:clinicassistant/Constant/Route/router.dart';
import 'package:clinicassistant/blocNotification/state.dart';
import 'package:flutter/material.dart';

import 'package:clinicassistant/Constant/sizer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Screen/clinicsPage/bloc/bloc.dart';
import '../Screen/doctorsPage/bloc/bloc.dart';
import '../Constant/color.dart';
import '../Constant/font.dart';
import '../blocNotification/bloc.dart';
import '../main.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class SearchBarView extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldkey;
  GlobalKey<FormState> form;
  TextEditingController textEditingController;
  bool isDoctor;
  String hint;
  AllDoctorsBloc allDoctorsBloc;
  AllClinicsBloc allClinicsBloc;
  bool isConnect;
  void Function() searchClicked;
  String? token;
  SearchBarView(
      {Key? key,
      required this.scaffoldkey,
      required this.form,
      required this.textEditingController,
      required this.isDoctor,
      required this.hint,
      required this.allDoctorsBloc,
      required this.allClinicsBloc,
      required this.isConnect,
      required this.searchClicked,
      this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: Sizer.getHeight(context) / 6,
      backgroundColor: Coloring.primary,
      leading: InkWell(
          onTap: () {
            RouterNav.fluroRouter.navigateTo(
                context, RouteName.Notification + "/${token}",
                routeSettings: RouteSettings());
          },
          child: Container(
            margin: EdgeInsets.only(top: 30.sp, left: 10.sp),
            child: badges.Badge(
              badgeAnimation: badges.BadgeAnimation.scale(),
              position: badges.BadgePosition.topEnd(),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.white,
              ),
              badgeContent:
                  BlocBuilder<NotificationSocketBloc, NotificationSocketState>(
                      bloc: notificationSocketBloc,
                      builder: (context, state) {
                        return Text(
                          "${state.getNumberOfUnReadState.num}",
                          style: TextStyle(
                              color: Coloring.primary, fontSize: 20.sp),
                        );
                      }),
              child: Icon(Icons.notifications_none_outlined,
                  size: Sizer.getTextSize(context, 0.1), color: Colors.white),
            ),
          )),
      actions: [
        isDoctor
            ? InkWell(
                onTap: () {
                  RouterNav.fluroRouter
                      .navigateTo(context, RouteName.filtering);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 6.sp),
                    child: Icon(Icons.filter_alt,
                        size: Sizer.getTextSize(context, 0.08),
                        color: Colors.white)),
              )
            : Container(),
        InkWell(
            onTap: () => scaffoldkey.currentState!.openEndDrawer(),
            child: Container(
                margin: EdgeInsets.only(right: 6.sp),
                child: Icon(Icons.menu,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white)))
      ],
      centerTitle: true,
      title: Row(
        children: [
          Expanded(
            flex: 6,
            child: Form(
              key: form,
              child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: textEditingController,
                  inputFormatters: [LengthLimitingTextInputFormatter(21)],
                  textDirection: TextDirection.rtl,
                  cursorColor: Coloring.primary,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "يجب ملئ الحقل";
                    }
                    return null;
                  },
                  style: TextStyle(
                      fontSize: Sizer.getTextSize(context, 0.05),
                      fontWeight: FontWeight.bold,
                      fontFamily: Font.fontfamily,
                      color: Coloring.primary2),
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: Font.fontfamily),
                      suffixIcon: InkWell(
                          onTap: isConnect ? searchClicked : null,
                          child: Icon(Icons.search,
                              size: 25.sp, color: Colors.grey)),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 4)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 4)),
                      errorMaxLines: 1,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.red, width: 3)),
                      isDense: true,
                      hintText: hint,
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                        fontSize: Sizer.getTextSize(context, 0.038),
                      ))),
            ),
          ),
          /*InkWell(
            onTap: () {
              if(isDoctor){
                if(form.currentState!.validate()) {
                  allDoctorsBloc.add(
                      LoadingDoctors(textEditingController.text,
                          null, null));
                }
              }else{
                //search on Clinic
              }
            },
            child: Expanded(
                child: Icon(Icons.search_rounded,
                    size: Sizer.getTextSize(context, 0.08),
                    color: Colors.white)),
          )*/
        ],
      ),
      elevation: 0,
    );
  }
}
