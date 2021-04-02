import 'package:flutter/material.dart';
import 'package:reunionou/Models/Event.dart';
import 'package:reunionou/Models/Invitation.dart';
import 'package:reunionou/Widgets/Invitation/InvitationPreview.dart';

class ParticipantList extends StatefulWidget {
  final Event event;

  ParticipantList(this.event);

  @override
  _ParticipantListState createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  List<Invitation> participants = [];
  bool loading = true, error = false;

  @override
  void initState() {
    super.initState();
    Invitation.getByEvent(0, 10, this.widget.event.id).then((value) {
      setState(() {
        this.participants = value;
        this.loading = false;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        this.loading = false;
        this.error = true;
      });
    });
  }

  @override
  void setState(fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (!this.loading && this.participants != null) {
      return Flexible(
        child: RefreshIndicator(
          onRefresh: () {
            setState(() {
              this.loading = true;
              this.error = false;
            });
            return Invitation.getByEvent(0, 10, this.widget.event.id)
                .then((value) {
              setState(() {
                this.participants = value;
                this.loading = false;
              });
            }).catchError((error) {
              print(error);
              setState(() {
                this.loading = false;
                this.error = true;
              });
            });
          },
          child: ListView.builder(
              itemCount: this.participants.length,
              itemBuilder: (context, index) {
                return InvitationPreview(this.participants[index]);
              }),
        ),
      );
    } else if (this.loading) {
      return Column(children: [
        CircularProgressIndicator(
          value: null,
          strokeWidth: 7.0,
        ),
        Text("Loading invitation ...")
      ]);
    } else
      return Center(child: Text("Could not load invitation."));
  }
}
