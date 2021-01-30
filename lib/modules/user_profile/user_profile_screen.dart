import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room/core/utils/ui_utils.dart';
import 'package:room/models/user.dart';
import 'package:room/modules/main/blocs/blocs.dart';
import 'package:room/modules/main/blocs/user_bloc.dart';
import 'package:room/resources/colors_res.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen(this.userId);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  void initState() {
    context.read<UserBloc>().add(GetOtherUserEvent(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: ColorsRes.white,
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadedState) {
              return StreamBuilder(
                stream: state.user,
                builder: (context, snapshot) {
                  if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final User user = snapshot.data;
                    return ListView(
                      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                      children: [
                        _buildProfileInfo(user),
                        const SizedBox(height: 20.0),
                      ],
                    );
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileInfo(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImageWidget(user),
        const SizedBox(height: 20.0),
        Container(
          height: 40.0,
          width: MediaQuery.of(context).size.width / 2.5,
          child: _buildUserNicknameWidget(user.fullName),
        ),
        const SizedBox(height: 10.0),
        Text(
          user?.email ?? 'email',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImageWidget(User user) {
    return user.image == null
        ? Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      ),
    )
        : Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        image: DecorationImage(
          image: NetworkImage(user.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUserNicknameWidget(String fullName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (fullName?.isNotEmpty ?? false) ? fullName : 'No name',
          style: TextStyle(
            fontSize: 20.0,
            color: (fullName?.isNotEmpty ?? false) ? Colors.black87 : Colors.black26,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
