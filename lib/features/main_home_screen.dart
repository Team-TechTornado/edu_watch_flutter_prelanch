import 'package:edu_watch/constants/form_button.dart';
import 'package:edu_watch/constants/gaps.dart';
import 'package:edu_watch/constants/sizes.dart';
import 'package:edu_watch/features/detail_screen.dart';
import 'package:edu_watch/services/api_sevices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernumberController = TextEditingController();

  String _usernumber = "";
  String _warningText = "기본적인 정보를 입력해주세요.";
  bool _isValid = false;
  bool _isValidId = false;
  String _id = "";
  String joinDate = "";
  String exitDate = "";

  @override
  void initState() {
    super.initState();
    _usernumberController.addListener(() {
      setState(() {
        _usernumber = _usernumberController.text;
      });
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("퇴실하셨습니다"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("확인"),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _usernumberController.dispose();
    super.dispose();
  }

  void isValid() {
    // 정수로만 구성되어 있는지 확인
    if (_usernumber.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(_usernumber)) {
      setState(() {
        _warningText = "숫자만 입력해주세요.";
      });
      return;
    } else if (_usernumber.length != 11) {
      setState(() {
        _warningText = "전화번호를 11자리로 입력해주세요.";
      });
      return;
    } else {
      _isValid = true;
    }
  }

  void isValidId() {
    try {
      ApiService.getId(_usernumber).then((value) {
        setState(() {
          _isValidId = true;
          _id = value;
        });
      });
    } catch (e) {
      setState(() {
        _warningText = "등록되지 않은 전화번호입니다.";
      });
      return;
    }
  }

  void _onNextTap() {
    isValid();
    isValidId();
    // 유효한 경우 다음 화면으로 이동
    if (_isValid && _isValidId) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const EmailScreen(),
        ),
      );
    }
    _isValid = false;
    _isValidId = false;

    DateTime now = DateTime.now();

    joinDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }

  void _onExitTap() {
    isValid();
    if (_isValid && _isValidId) {
      _showAlertDialog("오늘 하루도 수고하셨습니다.");
    }

    _isValid = false;
    _isValidId = false;

    DateTime now = DateTime.now();

    exitDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
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
                    onTap: _onExitTap,
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
