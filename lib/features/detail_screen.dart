import 'package:edu_watch/constants/form_button.dart';
import 'package:edu_watch/constants/gaps.dart';
import 'package:edu_watch/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSubmit() async {
    const url = 'https://discord.gg/WyEJa8BB';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v40,
              const Text(
                "환영합니다!",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v28,
              Center(
                child: GestureDetector(
                  onTap: _onSubmit,
                  child: FormButton(
                    disabled: false,
                    innerText: "디스코드 입장하기",
                    buttonColor: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
