import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/resources/styles_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';
import 'package:todo_app/presentation/ui/common/app_background/app_background.dart';
import 'package:todo_app/presentation/ui/login_page/viewmodel/login_page_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageViewModel>(
      create: (context) => LoginPageViewModel(),
      builder: ((context, child) {
        return const _LoginPageContent();
      }),
    );
  }
}

class _LoginPageContent extends StatefulWidget {
  const _LoginPageContent({super.key});

  @override
  State<_LoginPageContent> createState() => __LoginPageContentState();
}

class __LoginPageContentState extends State<_LoginPageContent> {
  final TextEditingController _userNameTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  late LoginPageViewModel _viewModel;

  final formKey = GlobalKey<FormState>();

  void _bind() {
    _viewModel = Provider.of<LoginPageViewModel>(context, listen: false);
    _viewModel.start();
    _userNameTEC.addListener(() => _viewModel.setUserName(_userNameTEC.text));
    _passwordTEC.addListener(() => _viewModel.setPassword(_passwordTEC.text));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizeConstants.s502,
      color: Colors.white,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: AppBackground(
              child: _body,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _body {
    return LayoutBuilder(builder: (_, boxConstraints) {
      // screenWidth = boxConstraints.maxWidth;
      return Container(
        width: boxConstraints.maxWidth,
        height: boxConstraints.maxHeight,
        margin: const EdgeInsets.only(top: AppMarginConstants.m16),
        child: Column(
          children: [
            Expanded(
              child: _getLogo,
            ),
            Expanded(
              flex: 2,
              child: _getForm,
            ),
          ],
        ),
      );
    });
  }

  Widget get _getForm => Form(
      key: formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMarginConstants.m12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getUserNameTF,
              _getPasswordTF,
              _getLoginButton,
            ],
          ),
        ),
      ));

  Widget get _getPasswordTF {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.2,
          child: Text(
            AppStrings.password,
            style: getBoldStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.header2TextColor),
          ),
        ),
        const SizedBox(height: AppSizeConstants.s6),
        StreamBuilder<String?>(
          stream: _viewModel.onPasswordErrorMessage,
          builder: (context, snapshot) {
            return TextFormField(
              controller: _passwordTEC,
              validator: _viewModel.passwordValidator,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                errorText: snapshot.data,
                hintText: AppStrings.password,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: getRegularStyle(
                  fontSize: FontSizeConstants.s20,
                  fontFamily: AppFontFamily.lato,
                  color: ColorConstants.header2TextColor),
              obscureText: false,
            );
          },
        ),
      ],
    );
  }

  Widget get _getUserNameTF {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.2,
          child: Text(
            AppStrings.userName,
            style: getBoldStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.header2TextColor),
          ),
        ),
        const SizedBox(height: AppSizeConstants.s6),
        StreamBuilder<String?>(
          stream: _viewModel.onUserNameErrorMessage,
          builder: (context, snapshot) {
            return TextFormField(
              controller: _userNameTEC,
              validator: _viewModel.userNameValidator,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                errorText: snapshot.data,
                hintText: AppStrings.userName,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: getRegularStyle(
                  fontSize: FontSizeConstants.s20,
                  fontFamily: AppFontFamily.lato,
                  color: ColorConstants.header2TextColor),
              obscureText: false,
            );
          },
        ),
      ],
    );
  }

  Widget get _getLogo => Image.asset(
        ImageAssets.splashImage,
        width: AppSizeConstants.s90,
        height: AppSizeConstants.s90,
      );

  Widget get _getLoginButton {
    return Container(
      margin: const EdgeInsets.only(
        top: AppMarginConstants.m20,
      ),
      width: AppSizeConstants.s132,
      height: AppSizeConstants.s46,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorConstants.blue,
            ColorConstants.blue,
            Color(0xFF42A5F5),
            Color.fromRGBO(0, 255, 255, 0.783),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: StreamBuilder<bool>(
          stream: _viewModel.outputAreAllInputsValid,
          builder: (context, snapshot) {
            callBackFunc() => _viewModel.login(context, formKey);

            return ElevatedButton(
                onPressed: callBackFunc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  AppStrings.login,
                  style: getRegularStyle(
                      fontSize: FontSizeConstants.s16,
                      fontFamily: AppFontFamily.lato,
                      color: ColorConstants.white),
                )));
          }),
    );
  }
}
