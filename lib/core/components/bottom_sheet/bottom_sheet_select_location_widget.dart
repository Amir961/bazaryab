

import 'dart:async';


import 'package:fare/core/components/loading/loading_widget.dart';
import 'package:fare/features/customer/bloc/add_customer_bloc.dart';
import 'package:fare/features/customer/models/city_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../features/language/utils/strings.dart';
import '../../../injection_container.dart';
import '../../res/media_res.dart';
import '../../utils/assets.dart';

import '../../utils/enum.dart';
import '../../utils/values.dart';
import '../button/button_widget.dart';
import '../dialog/dialog_manager.dart';
import '../inherited/tablet_checker/app_provider.dart';
import '../input/input.dart';
import '../text/text.dart';


class SelectLocationWidget extends StatefulWidget {


  final BuildContext context;
  final LatLng loc;

  const SelectLocationWidget({super.key,required this.context,required this.loc});

  @override
  State<SelectLocationWidget> createState() => _SelectLocationWidgetState();
}



class _SelectLocationWidgetState extends State<SelectLocationWidget> {

  double get inputWidth => MediaQuery.of(context).size.width * 0.8;
  double get marginWidth => MediaQuery.of(context).size.width * 0.1;



  LatLng? currentLocation;
  final mapController = MapController();








  @override
  void dispose() {



    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocation= widget.loc;
   // start();
  }




  @override
  Widget build(BuildContext context) {
    return


      SafeArea(
        child: PopScope<Object?>(
          canPop: false,
          child: SizedBox.expand(
            child: Stack(
              children: [

                _map,
                Positioned(
                    bottom: 20,
                    left: 12,
                    right: 12,
                    child:  ButtonWidget(
        
                      // isEnable: true,
                      isEnable: true,
        
        
                      onClick: () {
        
        
        
                        context.pop(currentLocation);
        
        
        
                      },
                      loading: false,
                      text: 'تایید',
                      width: inputWidth,
                      height: 45,
                    ),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  height: 90,
                  color: MyColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      MyText(text: "تعیین موقعیت",fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,),
                      InkWell(
                        onTap: (){

                          context.pop();
                        },
                        child: RotatedBox(
                            quarterTurns: 90,
                            child: Icon(Icons.play_arrow_rounded,color: Colors.white,size: 32,)),
                      ),
                    ],
                  ),
                ),
        
              ],
            ),
          ),
        ),
      );



  }


  Widget get _map=>  Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    height: double.infinity,
    child:
    //currentLocation==null ? LoadingWidget():

    FlutterMap(
      mapController: mapController,
      options: currentLocation!=null? MapOptions(
        initialCenter: currentLocation!,
        initialZoom: 14,
        onTap: (tapPosition, point) {
          setState(() => currentLocation = point);
        },
      ):MapOptions(),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'ir.rahko.fare',
        ),
        MarkerLayer(
          markers: [



            if(currentLocation!=null)
              Marker(
                  point: currentLocation!,
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset(MediaRes.location)
              ),
          ],
        ),

      ],
    ),
  );




}
