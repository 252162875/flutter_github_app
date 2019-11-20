import 'package:flutter/material.dart';
import 'package:flutter_github_app/common/funs.dart';
import 'package:flutter_github_app/common/icons.dart';
import 'package:flutter_github_app/i10n/localization_intl.dart';
import 'package:flutter_github_app/models/Repo.dart';

class RepoItem extends StatefulWidget {
  RepoItem(this.repo) : super(key: ValueKey(repo.id));

  final Repo repo;

  @override
  State<StatefulWidget> createState() {
    return _RepoItemState();
  }
}

class _RepoItemState extends State<RepoItem> {
  @override
  Widget build(BuildContext context) {
    var subtitle = Text("我是副标题-哈哈哈");
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: gmAvatar(widget.repo.owner.avatarUrl,
                    width: 24.0, borderRadius: BorderRadius.circular(12)),
                title: Text(
                  widget.repo.owner.login,
                  textScaleFactor: 0.9,
                ),
                subtitle: subtitle,
                trailing: Text(widget.repo.language ?? "TRAILING"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.repo.fork
                          ? widget.repo.fullName
                          : widget.repo.name,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: widget.repo.fork
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                      child: (widget.repo.description == null ||
                              widget.repo.description.isEmpty)
                          ? Text(
                              GmLocalizations.of(context).noDescription,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700],
                              ),
                            )
                          : Text(
                              widget.repo.description,
                              maxLines: 3,
                              style: TextStyle(
                                height: 1.15,
                                fontSize: 13.0,
                                color: Colors.blueGrey[700],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              _buildBottom(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
        data: IconThemeData(
          color: Colors.grey,
          size: 15.0,
        ),
        child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Builder(builder: (context) {
                var children = <Widget>[
                  Icon(Icons.star),
                  Text("  " +
                      widget.repo.stargazersCount
                          .toString()
                          .padRight(paddingWidth)),
                  Icon(Icons.info_outline),
                  Text("  " +
                      widget.repo.openIssuesCount
                          .toString()
                          .padRight(paddingWidth)),
                  Icon(MyIcons.fork),
                  Text("  " +
                      widget.repo.forksCount.toString().padRight(paddingWidth))
                ];
                if (widget.repo.fork) {
                  children.add(Text("Forked".padRight(paddingWidth)));
                }
                if (widget.repo.private == true) {
                  children.addAll(<Widget>[
                    Icon(Icons.lock),
                    Text(" private".padRight(paddingWidth))
                  ]);
                }
                return Row(children: children);
              }),
            )));
  }
}
