import 'package:bed3avendor/view/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:bed3avendor/localization/language_constrants.dart';
import 'package:bed3avendor/provider/theme_provider.dart';
import 'package:bed3avendor/utill/dimensions.dart';
import 'package:bed3avendor/utill/images.dart';
import 'package:bed3avendor/utill/styles.dart';
import 'package:bed3avendor/view/base/custom_dialog.dart';
import 'package:bed3avendor/view/screens/bank_info/bank_info_view.dart';
import 'package:bed3avendor/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:bed3avendor/view/screens/settings/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../product/product_list_screen.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: ThemeShadow.getShadow(context),
            ),
            height: Dimensions.profile_card_height,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: Dimensions.ICON_SIZE_DEFAULT,
                      height: Dimensions.ICON_SIZE_DEFAULT,
                      child: Image.asset(Images.dark)),
                  SizedBox(
                    width: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  Text(
                      !Provider.of<ThemeProvider>(context).darkTheme
                          ? '${getTranslated('dark_theme', context)}'
                          : '${getTranslated('light_theme', context)}',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                  Expanded(child: SizedBox()),
                  FlutterSwitch(
                    width: 50.0,
                    height: 28.0,
                    toggleSize: 20.0,
                    value: !Provider.of<ThemeProvider>(context).darkTheme,
                    borderRadius: 20.0,
                    activeColor: Theme.of(context).primaryColor.withOpacity(.5),
                    padding: 3.0,
                    activeIcon: Image.asset(Images.dark_mode,
                        width: 30, height: 30, fit: BoxFit.scaleDown),
                    inactiveIcon: Image.asset(
                      Images.light_mode,
                      width: 30,
                      height: 30,
                      fit: BoxFit.scaleDown,
                    ),
                    onToggle: (bool isActive) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),

          // Provider.of<SplashProvider>(context, listen: false).configModel!.shippingMethod == 'sellerwise_shipping'?
          // SectionItemWidget(icon: Images.box, title: 'shipping_method',
          //   onTap: (){
          //   if(Provider.of<ShippingProvider>(context, listen: false).selectedShippingType == "category_wise"){
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => CategoryWiseShippingScreen()));
          //   }else if(Provider.of<ShippingProvider>(context, listen: false).selectedShippingType == "order_wise"){
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderWiseShippingScreen()));
          //   }else{
          //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductWiseShipping()));
          //   }},):SizedBox(),
          //
          //
          // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

          SectionItemWidget(
            icon: Images.product_num,
            title: 'عدد الاصناف',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProductListMenuScreen()));
            },
          ),
          SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),

          SectionItemWidget(
            icon: Images.edit_profile,
            title: 'settings',
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
          ),
          SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),

          SectionItemWidget(
            icon: Images.bank_card,
            title: 'bank_info',
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BankInfoView()));
            },
          ),

          // SizedBox(
          //   height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          // ),
          // SectionItemWidget(
          //   icon: Images.resetpassword,
          //   title: 'تغيير كلمة المرور',
          //   onTap: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (_) => BankInfoView()));
          //   },
          // ),

          SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),
          SectionItemWidget(
            icon: Images.logOut2,
            title: 'logout',
            onTap: () async {
              ///clear data
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SplashScreen()));
            },
          ),

          SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),

          SectionItemWidget(
            icon: Images.delete,
            title: 'delete_account',
            onTap: () => showAnimatedDialog(
                context, SignOutConfirmationDialog(isDelete: true),
                isFlip: true),
          ),
        ],
      ),
    );
  }
}

class SectionItemWidget extends StatelessWidget {
  final String? icon;
  final String? title;
  final Function? onTap;
  const SectionItemWidget({Key? key, this.onTap, this.icon, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: ThemeShadow.getShadow(context)),
        height: Dimensions.profile_card_height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(
            children: [
              Container(
                  width: Dimensions.ICON_SIZE_DEFAULT,
                  height: Dimensions.ICON_SIZE_DEFAULT,
                  child: Image.asset(icon!)),
              SizedBox(
                width: Dimensions.PADDING_SIZE_SMALL,
              ),
              Expanded(
                child: Text(
                    '${getTranslated(title, context) != null ? getTranslated(title, context) : title}',
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT)),
              ),
              Container(
                  width: Dimensions.ICON_SIZE_DEFAULT,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
