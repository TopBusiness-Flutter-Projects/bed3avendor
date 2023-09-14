import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/view/base/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: ColorResources.getHomeBg(context),
        borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(25),
            topRight: Radius.circular(25)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(

            onTap: ()=> Navigator.pop(context),
            child:Container(
              height: 50,
              color: Theme.of(context).primaryColor,
              child: Row(children: [Spacer(), Text(
                'كيس موتزريلا 180 جرام',
                style: robotoMedium.copyWith(
                    fontSize: Dimensions
                        .PADDING_SIZE_MEDIUM,color: Colors.white),

              ),Spacer(),
              Icon(Icons.arrow_back_ios_new,color: Colors.white,),  SizedBox(width: Dimensions.PADDING_SIZE_LARGE),],),


            ),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:50),
            child: Text(getTranslated('price', context)!,
                style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:45),
            child: Row(children: [
              Container(child: Center(child: Icon(Icons.add,color: Theme.of(context).primaryColor,)),
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                color: Theme.of(context).primaryColor.withOpacity(.06)
              ),
              ),
              Spacer()
,            Text("3200 ج.م",
                  style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
              Spacer()
              ,
              Container(child: Center(child: Icon(Icons.remove,color: Colors.red,)),
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                    color: Colors.red.withOpacity(.06)
                ),
              ),
            ],),
          ) ,
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:50),
            child: Text('المتاح فى المخزن',
                style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:45),
            child: Row(children: [
              Container(child: Center(child: Icon(Icons.add,color: Theme.of(context).primaryColor,)),
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                color: Theme.of(context).primaryColor.withOpacity(.06)
              ),
              ),
              Spacer()
,            Text("غير محدود",
                  style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
              Spacer()
              ,
              Container(child: Center(child: Icon(Icons.remove,color: Colors.red,)),
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                    color: Colors.red.withOpacity(.06)
                ),
              ),
            ],),
          ) 
          
          ,
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:50),
            child: Text("الحد الاقصى",
                style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:45),
            child: Row(children: [
              Container(child: Center(child: Icon(Icons.add,color: Theme.of(context).primaryColor,)),
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                color: Theme.of(context).primaryColor.withOpacity(.06)
              ),
              ),
              Spacer()
,            Text("3",
                  style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context))),
              Spacer()
              ,
              Container(child: Center(child: Icon(Icons.remove,color: Colors.red,)),
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_LARGE)),
                    color: Colors.red.withOpacity(.06)
                ),
              ),
            ],),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
Padding(
  padding: const EdgeInsets.symmetric(horizontal:50),
  child:   CustomButton(btnTxt: 'حفظ التعديلات',),
),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

        ],
      ),
    );
  }
}
