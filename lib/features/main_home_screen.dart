import 'package:edu_watch/constants/form_button.dart';
import 'package:edu_watch/constants/gaps.dart';
import 'package:edu_watch/constants/sizes.dart';
import 'package:edu_watch/features/detail_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernumberController = TextEditingController();

  String _usernumber = "";
  String _warningText = "기본적인 정보를 입력해주세요.";

  @override
  void initState() {
    super.initState();
    _usernumberController.addListener(() {
      setState(() {
        _usernumber = _usernumberController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernumberController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    // 정수로만 구성되어 있는지 확인
    if (_usernumber.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(_usernumber)) {
      setState(() {
        _warningText = "숫자만 입력해주세요.";
      });
      return;
    }

    // 11자리인지 확인
    if (_usernumber.length != 11) {
      setState(() {
        _warningText = "전화번호를 11자리로 입력해주세요.";
      });
      return;
    }

    // 유효한 경우 다음 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EduWatch",
          style: TextStyle(
            fontSize: Sizes.size28,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "전화 번호",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "학부모 전화번호를 입력하세요.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernumberController,
              decoration: InputDecoration(
                hintText: "'-' 없이 입력하세요.",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColorLight,
            ),
            Gaps.v10,
            Text(
              _warningText,
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.red,
              ),
            ),
            Gaps.v28,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _onNextTap,
                    child: FormButton(
                      disabled: _usernumber.isEmpty,
                      innerText: "입실",
                      buttonColor: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
                Gaps.v28,
                Expanded(
                  child: GestureDetector(
                    onTap: _onNextTap,
                    child: FormButton(
                      disabled: _usernumber.isEmpty,
                      innerText: "퇴실",
                      buttonColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
