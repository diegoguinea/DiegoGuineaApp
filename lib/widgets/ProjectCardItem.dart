import 'package:flutter/material.dart';
import 'package:flutter_project/services/lang.dart';

class ProjectCardItem extends StatelessWidget {
  const ProjectCardItem({
    this.projectName,
    this.numSpots,
  });

  final String projectName;
  final String numSpots;

  @override
  Widget build(BuildContext context) {
    multilang localizations = Localizations.of<multilang>(context, multilang);

    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          //TODO poner en la misma fila "city" +  nombre ciudad
          //poner en la misma fila "Num spots" + numero
          Text(
            localizations.ciudad,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.blue
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            projectName,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            localizations.num_spots,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
                color: Colors.blue

            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            numSpots,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),        ],
      ),
    );
  }
}