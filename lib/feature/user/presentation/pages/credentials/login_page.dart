
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_app/feature/app/constants/app_const.dart';

import 'package:whatsapp_clone_app/feature/app/home/home_page.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/auth/cubit/auth_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/cubit/credential/cubit/credential_cubit.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/pages/credentials/intial_profile_submit_page.dart';
import 'package:whatsapp_clone_app/feature/user/presentation/pages/credentials/opt_page.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _phoneController = TextEditingController();

  static Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode("92");
  String countryCode = _selectedFilteredDialogCountry.phoneCode;

  String phoneNumber = "";

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit,CredentialState>(builder: (context, state) {
      if(state is CredentialLoading ){
        return const Center(child: CircularProgressIndicator(),);
      }
      if(state is CredentialPhoneAuthSmsCodeRecived ){
        return const OtpPage();
      }
      if(state is CredentialPhoneAuthProfileInfo){
        return IntialProfileSubmitPage(phoneNumber: phoneNumber,);
      }
      if(state is CredentialSucess){
        return BlocBuilder<AuthCubit,AuthState>(builder: (context, authState) {
          if(authState is Authenticated){
            return HomePage(uid: authState.uid);
          }
          return _bodyWidget(context);
        },
        );
        
      }

      return _bodyWidget(context);
    }, listener: (context, credentialStateListener) {
        if(credentialStateListener is CredentialSucess){
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if(credentialStateListener is CredentialFailure ){
          toast('Some thing went wrong while logging in');
        }
    },);
  }

  Scaffold _bodyWidget(BuildContext context) {
    return Scaffold(
    body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Text(
                    "Verify your phone number",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: tabColor),
                  ),
                ),
                const Text(
                  "WhatsApp Clone will send you SMS message (carrier charges may apply) to verify your phone number. Enter the country code and phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                  onTap: (){
                    _openFilteredCountryPickerDialog(context);
                  },
                  title: _buildDialogItem(_selectedFilteredDialogCountry),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.50,
                            color: tabColor,
                          ),
                        ),
                      ),
                      width: 80,
                      height: 42,
                      alignment: Alignment.center,
                      child: Text(
                          _selectedFilteredDialogCountry.phoneCode),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 1.5),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                BorderSide(color: tabColor, width: 1.5))),
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "Phone Number", 
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          GestureDetector(
            onTap:_submitVerifyPhoneNumber,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: tabColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

        ],
      ),
    ),
  );
  }

  

   _openFilteredCountryPickerDialog(BuildContext context) {
   return showDialog(
        context: context,
        builder: (_) =>
            Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: tabColor,
                ),
                child: CountryPickerDialog(
                  titlePadding: const EdgeInsets.all(8.0),
                  searchCursorColor: tabColor,
                  searchInputDecoration: const InputDecoration(
                    hintText: "Search",
                  ),
                  isSearchable: true,
                  title: const Text("Select your phone code"),
                  onValuePicked: (Country country) {
                    setState(() {
                      _selectedFilteredDialogCountry = country;
                      countryCode = country.phoneCode;
                    });
                  },
                  itemBuilder: (Country country) => _buildDialogItem(country),
                )
            ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: tabColor, width: 1.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Text(" +${country.phoneCode}"),
          Expanded(child: Text(
            " ${country.name}", maxLines: 1, overflow: TextOverflow.ellipsis,)),
          const Spacer(),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }


  void _submitVerifyPhoneNumber(){
    if(_phoneController.text.isNotEmpty){
      phoneNumber = '+$countryCode${_phoneController.text}';
      print('phone number : $phoneNumber');
      BlocProvider.of<CredentialCubit>(context).submitVerifyPhoneNumber(phoneNumber: phoneNumber);
    }else{
      toast('Please enter the phone number');
    }
  }
}
