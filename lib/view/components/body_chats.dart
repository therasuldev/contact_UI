import 'package:contact_ui/core/bloc/app_cubit.dart';
import 'package:contact_ui/view/components/stories.dart';
import 'package:contact_ui/view/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/bloc/app_state.dart';
import '../constant/const_list.dart';

class BodyChats extends StatefulWidget {
  const BodyChats({Key? key}) : super(key: key);

  @override
  _BodyChatsState createState() => _BodyChatsState();
}

class _BodyChatsState extends State<BodyChats> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    const storiesStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar(padding),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: size.height * .8,
            decoration: ViewUtils.bodyDecoration(),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  if (state.isInProgress) {
                    return const SpinKitDualRing(color: red);
                  }
                  if (state.isSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Stories', style: storiesStyle),
                          _bodyStories(state),
                          const Text('Chats', style: storiesStyle),
                          bodyChats(state),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(EdgeInsets padding) {
    return AppBar(
      backgroundColor: backgroundColor,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: padding.top / 2, left: 7),
        child: _avatarAndDisplayName(),
      ),
      actions: const [
        Icon(Icons.search, color: white),
        Icon(Icons.more_vert, color: white)
      ],
      toolbarHeight: 80,
      elevation: 0,
    );
  }

  Widget bodyChats(AppState state) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.data?.length ?? 0,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, i) {
        final user = state.data![i];
        return ListTile(
          contentPadding: const EdgeInsets.only(right: 10),
          title: Text(user.userName),
          subtitle: Text('Hi  ${user.userName}'),
          leading: onlineStatus(state, i),
          trailing: const Text('just now'),
        );
      },
    );
  }

  SizedBox _bodyStories(AppState state) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: state.data!.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          final user = state.data![i];
          return stories(
            index: i,
            username: user.userName,
            image: user.userImage,
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget onlineStatus(AppState state, int i) {
    final user = state.data![i];
    return Container(
      height: 45,
      width: 45,
      decoration: ViewUtils.profileDecoration(user.userImage),
      child: i % 2 == 0
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: ViewUtils.onlineStatus(),
                  ),
                )
              ],
            )
          : null,
    );
  }

  Widget _avatarAndDisplayName() {
    const contactNameStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white);
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: ViewUtils.displayAvatarDecoration(),
        ),
        const SizedBox(width: 5),
        const Text('Celine', style: contactNameStyle),
      ],
    );
  }
}
