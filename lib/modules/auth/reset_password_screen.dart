import 'package:flutter/material.dart';
import 'package:room/core/widgets/design_button.dart';
import 'package:room/core/widgets/design_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            _buildBackButtonWidget(),
            Spacer(),
            _buildTitleWidget(),
            const SizedBox(height: 25.0),
            _buildInputFieldWidget(),
            Spacer(),
            _buildResetPasswordButtonWidget(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BackButton(color: Colors.black87),
      ],
    );
  }

  Widget _buildTitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Enter your email. Reset link will be sent you your email',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInputFieldWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DesignInputField(
        hint: 'Email',
        controller: _emailController,
      ),
    );
  }

  Widget _buildResetPasswordButtonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: DesignButton(
              title: 'Reset password',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
