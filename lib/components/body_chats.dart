import 'package:contact_ui/components/stories.dart';
import 'package:contact_ui/core/bloc/app_cubit.dart';
import 'package:contact_ui/core/bloc/app_state.dart';
import 'package:contact_ui/view/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constant/const_list.dart';

class BodyChats extends StatefulWidget {
  const BodyChats({Key? key}) : super(key: key);

  @override
  _BodyChatsState createState() => _BodyChatsState();
}

class _BodyChatsState extends State<BodyChats> {
  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    const storiesStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
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
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: size.height * .8,
            decoration: ViewUtils.bodyDecoration(),
            child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
              if (state is AppLoading) {
                return const SpinKitSpinningLines(color: black);
              }

              if (state is AppSuccess) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Stories', style: storiesStyle),
                      bodyStories(state),
                      const Text('Chats', style: storiesStyle),
                      bodyChats(state),
                    ],
                  ),
                );
              }
              if (state is AppFailed) {
                return Center(child: Text(state.error));
              } else {
                return const Center(child: Text('Not Data'));
              }
            }),
          ),
        ),
      ),
    );
  }

  Expanded bodyChats(AppSuccess state) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return ListTile(
            contentPadding: const EdgeInsets.only(right: 10),
            title: Text(state.data[i]['login']),
            subtitle: Text('Hi  ${state.data[i]['login']}'),
            leading: onlineStatus(state, i),
            trailing: const Text('just now'),
          );
        },
      ),
    );
  }

  Container onlineStatus(AppSuccess state, int i) {
    return Container(
      height: 45,
      width: 45,
      decoration: ViewUtils.profileDecoration(state.data[i]['avatar_url']),
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

  SizedBox bodyStories(AppSuccess state) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: state.data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return stories(
            index: index,
            username: state.data[index]['login'],
            image: state.data[index]['avatar_url'],
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _avatarAndDisplayName() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: ViewUtils.displayDecoration(),
        ),
        const SizedBox(width: 5),
        Text(
          'Celine',
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
      ],
    );
  }

  ListView componentsDialoq() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) => ListTile(
          iconColor: white,
          textColor: white,
          enabled: true,
          leading: Icon(icons[i]),
          title: Text(title[i], softWrap: true)),
      separatorBuilder: (context, i) => const Divider(
        color: dividerColor,
        height: 2,
        thickness: 1.5,
        indent: 1,
        endIndent: 1,
      ),
      itemCount: icons.length,
    );
  }
}
