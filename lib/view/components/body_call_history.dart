import 'package:contact_ui/core/bloc/app_cubit.dart';
import 'package:contact_ui/view/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/bloc/app_state.dart';
import '../constant/const_list.dart';

class BodyCallHistory extends StatefulWidget {
  const BodyCallHistory({Key? key}) : super(key: key);

  @override
  _BodyCallHistoryState createState() => _BodyCallHistoryState();
}

class _BodyCallHistoryState extends State<BodyCallHistory> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  bodyCallHistory()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyCallHistory() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state.isInProgress) {
          return const SpinKitDualRing(color: red);
        }
        if (state.isSuccess) {
          return Expanded(
            child: ListView.custom(
              physics: const BouncingScrollPhysics(),
              childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {
                  const style = TextStyle(fontWeight: FontWeight.bold);
                  return index % 3 == 0 && index != 0
                      ? Text(
                          'September ${index + 2}, 2021',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      : ListTile(
                          title:
                              Text(state.data![index].userName, style: style),
                          subtitle: const Text('07:14PM'),
                          contentPadding: const EdgeInsets.only(right: 10),
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: ViewUtils.profileDecoration(
                                state.data![index].userImage),
                          ),
                          trailing: index % 2 == 0
                              ? const Icon(Icons.video_call, color: activeColor)
                              : const Icon(Icons.call, color: red));
                },
                childCount: 12,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  AppBar appBar(EdgeInsets padding) {
    const textStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white);
    return AppBar(
      backgroundColor: backgroundColor,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: padding.top, left: 7),
        child: const Text('Call Log', style: textStyle),
      ),
      actions: const [
        Icon(Icons.search, color: white),
        Icon(Icons.more_vert, color: white)
      ],
      toolbarHeight: 80,
      elevation: 0,
    );
  }
}
