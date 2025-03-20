
import 'package:bw_project/constants/colors.dart';
import 'package:bw_project/screens/profile/bloc/profile_bloc.dart';
import 'package:bw_project/screens/profile/bloc/profile_event.dart';
import 'package:bw_project/screens/profile/bloc/profile_state.dart';
import 'package:bw_project/screens/profile/widget/profile_avatar.dart';
import 'package:bw_project/screens/profile/widget/profile_container.dart';
import 'package:bw_project/screens/profile/widget/profile_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfileEvent()),
      child: Scaffold(
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: AppColors.blueWhiteGradient
              ),
              child: _buildContent(context, state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileState state) {
    if (state is ProfileLoading || state is ProfileInitial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProfileLoaded) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200),
            
            ProfileAvatar(
              profileImageUrl: state.profileImageUrl,
              username: state.username,
              email: state.email,
            ),
            
            const SizedBox(height: 20),
            
            ProfileInfoContainer(
              label: state.username ?? "No Username",
            ),
            
            const SizedBox(height: 10),
            
            ProfileInfoContainer(
              label: state.email ?? "No Email",
            ),
            
            const SizedBox(height: 30),
            
            ProfileInfoCard(
              onSignOutPressed: () {
                BlocProvider.of<ProfileBloc>(context).add(SignOutEvent(context));
              },
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      );
    } else if (state is ProfileError) {
      return Center(
        child: Text("Error: ${state.message}"),
      );
    } else {
      return const Center(
        child: Text("Unknown state"),
      );
    }
  }
}