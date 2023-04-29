import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/Constant/code.dart';
import 'package:clinicassistant/Constant/color.dart';
import 'package:clinicassistant/Constant/font.dart';
import 'package:clinicassistant/Constant/sizer.dart';
import 'package:clinicassistant/clinicsPage/bloc/bloc.dart';
import 'package:clinicassistant/clinicsPage/bloc/events.dart';
import 'package:clinicassistant/clinicsPage/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AllClinics extends StatefulWidget {
  const AllClinics({Key? key}) : super(key: key);

  @override
  State<AllClinics> createState() => _AllClinicsState();
}

class _AllClinicsState extends State<AllClinics> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AllClinicsBloc(InitialState());
      },
      child: Scaffold(
        key: _scaffoldkey,
        appBar: MyAppBar(),
        drawer: Code.DrawerNative(context),
        body: BodyClinics(),
      ),
    );

  }
  /*Widget AppBarClinics(BuildContext context ,  bool isSearchSelected) {
    return AppBar(
      backgroundColor:  Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white
      ),
      leading: InkWell(
          onTap: () {
            _scaffoldkey.currentState!.openDrawer();
          },
          child: Icon(Icons.menu ,size: 30, color: Coloring.primary)),
      actions: [
        InkWell(onTap: () {
          AllClinicsBloc.get(context).add(SearchEvent());
        },
            child:isSearchSelected ? Icon(Icons.cancel_outlined,size: 30, color: Coloring.primary)
                :Icon(Icons.search ,size: 30, color: Coloring.primary)
        ),
        !isSearchSelected?Icon(Icons.notifications_none ,size: 30, color: Coloring.primary)
            :Container()
      ],
      centerTitle: true,
      title: !isSearchSelected? Text("أوجد عيادتك",style: TextStyle(
          fontWeight: FontWeight.bold , fontFamily: Font.fontfamily , color: Coloring.customgrey))
          :Container(
             width: 350,
              height: 35,
            child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(21)
            ],
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 18 ,fontFamily: Font.fontfamily ,color: Coloring.customgrey),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Coloring.primary)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Coloring.primary)
                ),
                errorMaxLines: 21,
                prefix: Padding(
                    padding: EdgeInsets.only(top: 50 ,left: 15),
                    child: Icon(Icons.search ,size: 25, color: Coloring.primary)),
                hintText: 'أدخل اسم عيادتك ...',
                contentPadding: EdgeInsets.only(top: 25 , right: 25),
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(
                  color: Coloring.customgrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                )
            )
        ),
      ),
      elevation: 1,
    );
  }
  */
  //Make AppBar
  MyAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(Sizer.getHeight(context)/8),
      child: BlocConsumer<AllClinicsBloc , AllClinicStates>(
          listener: (context,AllClinicStates state) {},
          builder: (context , AllClinicStates state) {
            bool isSearchSelected = AllClinicsBloc.get(context).isSearch;
    return Code.AppBarDoctorsAndClinics(_scaffoldkey,context, isSearchSelected ,false,
    "أوجد عيادتك" , "أدخل اسم عيادتك ...");
        }
      ),
    );
  }
  //Make Body
  Widget BodyClinics() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Coloring.custompurble

          ),
          margin: EdgeInsets.all(15),
          width: double.infinity,
          height: Sizer.getHeight(context)/15,
          child: Center(
            child: Text("البحث حسب الموقع",textAlign: TextAlign.center, style: TextStyle(
                 fontFamily: Font.fontfamily ,fontWeight: FontWeight.bold,fontSize: Sizer.getTextSize(context, 0.05), color: Colors.white),),
          ),
        ),
        Expanded(
          child: Container(
            width: Sizer.getWidth(context)/1.1,
            child: FutureBuilder(
              future: API.getClinics(),
              builder: (context, snapshot)
               {
                if(snapshot.connectionState==ConnectionState.waiting){
               return Shimmer.fromColors(
               direction: ShimmerDirection.ttb,
               loop: 10,
               child: Container(
               width: Sizer.getWidth(context)/1.1,
               child: GridView.builder(gridDelegate:
               SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisSpacing: 5,
               mainAxisSpacing: 15,
               crossAxisCount: 2,
               mainAxisExtent : Sizer.getHeight(context)/1.8
               ),
               scrollDirection: Axis.vertical,
               physics: ScrollPhysics(),
               itemBuilder: (context, index) {
               return Container(
               decoration: BoxDecoration(
               color: Coloring.custompurble,
               borderRadius: BorderRadius.circular(25),
               ),
               );
               //   child: Shimmer.fromColors(
               //       child: Container(
               //   decoration: BoxDecoration(
               //   borderRadius: BorderRadius.circular(25),
               // ),
               //   )
               //       , baseColor: Coloring.customgrey, highlightColor: Coloring.primary),
               // );
               }),
               )
               , baseColor: Colors.white, highlightColor: Coloring.custompurble);
               }else if (snapshot.hasData){
                  return GridView.builder
                    (
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                    mainAxisExtent : Sizer.getHeight(context)/1.8
               ),
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                      itemCount: snapshot.data!.clinics!.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                              // gradient: SweepGradient(colors: [
                              //   Colors.white,
                              //   Coloring.custompurble,
                              //   Colors.white,
                              // ]),
                              color: Coloring.customgrey2,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Container(
                                  width: Sizer.getWidth(context)/2,
                                  height: Sizer.getHeight(context)/4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                       image: AssetImage(
                                        "assets/images/clinic1.png"),
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                      repeat: ImageRepeat.noRepeat,
                                    ),

                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Center(
                                    child: Text(snapshot.data!.clinics![index].clinicName!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black,
                                        fontFamily: Font.fontfamily,
                                        fontSize: Sizer.getTextSize(context, 0.05),
                                        fontWeight: FontWeight.bold))),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Divider(thickness: 5 , color: Colors.white,),
                                      Center(child: Text("عدد الأطباء : ${snapshot.data!.clinics![index].numDoctors}",
                                          style: TextStyle(color: Colors.black,
                                              fontFamily: Font.fontfamily,
                                              fontSize: Sizer.getTextSize(context, 0.05),
                                              fontWeight: FontWeight.bold))),
                                      Center(
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.location_on_outlined,
                                                color: Coloring.custompurble ,
                                                size: Sizer.getTextSize(context, 0.04),),
                                              Text(snapshot.data!.clinics![index].location!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.black,
                                                      fontFamily: Font.fontfamily,
                                                      fontSize: Sizer.getTextSize(context, 0.04),
                                                      fontWeight: FontWeight.bold)),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                ],
                            ));
                      });
                }else{
                 return Center(child: Text("NotFoundData!!"));
                }
              }
            ),
          ),
        )
      ],
    );
  }
}




