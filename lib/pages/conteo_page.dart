import 'package:contador/provider/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:contador/provider/socket_services.dart';
import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class ConteoPage extends StatefulWidget {
  @override
  _ConteoPageState createState() => _ConteoPageState();
}

class _ConteoPageState extends State<ConteoPage> {
  final _controllerArea = TextEditingController();
  final _controllerConteo = TextEditingController();
  final _controllerCodeBar = TextEditingController();
  final _controllerCantidad = TextEditingController();

  var areaField = FocusNode();
  var conteoField = FocusNode();
  var codeBarField = FocusNode();
  var cantidadField = FocusNode();

  String _nombre = '';

  List<Lectura> _lLecturas = [];
  // Lectura(
  //     id: 1,
  //     area: 1,
  //     conteo: 1,
  //     contador: '1111',
  //     barCode: '1111111',
  //     cantidad: 1,
  //     orden: 1,
  //     estado: 'B',
  //     fechahora: '',
  //     transmitido: 'N',
  //     fhTransmitido: ''),

  //   Lectura(
  //       id: 1,
  //       area: 1,
  //       conteo: 1,
  //       contador: '1111',
  //       barCode: '2222222',
  //       cantidad: 1,
  //       orden: 2,
  //       estado: 'B',
  //       fechahora: '',
  //       transmitido: 'N',
  //       fhTransmitido: ''),
  //   Lectura(
  //       id: 3,
  //       area: 1,
  //       conteo: 1,
  //       contador: '1111',
  //       barCode: '3333333',
  //       cantidad: 1,
  //       orden: 3,
  //       estado: 'B',
  //       fechahora: '',
  //       transmitido: 'N',
  //       fhTransmitido: ''),
  //   Lectura(
  //       id: 4,
  //       area: 1,
  //       conteo: 1,
  //       contador: '1111',
  //       barCode: '4444444',
  //       cantidad: 1,
  //       orden: 4,
  //       estado: 'B',
  //       fechahora: '',
  //       transmitido: 'N',
  //       fhTransmitido: ''),
  //   Lectura(
  //       id: 5,
  //       area: 1,
  //       conteo: 1,
  //       contador: '1111',
  //       barCode: '5555555',
  //       cantidad: 1,
  //       orden: 5,
  //       estado: 'B',
  //       fechahora: '',
  //       transmitido: 'N',
  //       fhTransmitido: ''),
  //   Lectura(
  //       id: 6,
  //       area: 1,
  //       conteo: 1,
  //       contador: '1111',
  //       barCode: '6666666',
  //       cantidad: 1,
  //       orden: 5,
  //       estado: 'B',
  //       fechahora: '',
  //       transmitido: 'N',
  //       fhTransmitido: '')
  // ];

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contador'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: _scanQR,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              DBProvider.db.deleteScan(1);
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: DBProvider.db.deleteAllScan, //() {},
          ),

          (socketService.serverStatus == ServerStatus.Online)
              ? Icon(Icons.check_circle, color: Colors.green[300])
              : Icon(Icons.check_circle, color: Colors.red)
          //Icon(Icons.check_circle, color: Colors.green[300]),
        ],
      ),
      body: //_crearLecturas(context),
          Column(
//        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearArea(context),
          Divider(),
          _crearConteo(context),
          Divider(),
          _crearTotal(),
          Divider(),
          _crearCantidad(context),
          Divider(),
          _crearInput(context),
          Divider(),
          Expanded(child: _crearLecturasDB(context)),
          //Expanded(child: _crearLecturas(context)),
        ],
      ),
      //  floatingActionButton: _crearFlotantes(),
    );
  }

  _scanQR() async {
    print('scanQR');

    String barCode = '555555';

    // try {

    //   var result = await BarcodeScanner.scan();

    //   print(result.type); // The result type (barcode, cancelled, failed)
    //   print(result.rawContent); // The barcode content
    //   print(result.format); // The barcode format (as enum)
    //   print(result.formatNote); // If a unknown format was scanned this fie

    //   barCode = result.rawContent;

    // } catch (e) {
    //   print(e.toString());
    // }

    Lectura lectura = Lectura(
        //id: 1, //'${_lLecturas.length}',
        area: int.parse(_controllerArea.text),
        conteo: int.parse(_controllerConteo.text),
        contador: '1111',
        barCode: barCode, //_controllerCodeBar.text,
        cantidad: int.parse(_controllerCantidad.text),
        orden: 1,
        estado: 'B',
        fechahora: DateTime.now().toString(),
        transmitido: 'N',
        fhTransmitido: '');

    DBProvider.db.nuevoScan(lectura);
  }

  Widget _crearInput(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return TextField(
      decoration: InputDecoration(
        hintText: 'Codigo de Barras',
        labelText: 'Codigo de Barras',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      controller: _controllerCodeBar,
      focusNode: codeBarField,
      onSubmitted: (value) {
        print('$value');
        print('Area: ${_controllerArea.text}');

        if (_controllerCodeBar.text.isEmpty) {
          FocusScope.of(context).requestFocus(codeBarField);
        } else {
          Lectura lectura1 = Lectura(
              //id: _lLecturas.length, //'${_lLecturas.length}',
              area: int.parse(_controllerArea.text),
              conteo: int.parse(_controllerConteo.text),
              contador: '1111',
              barCode: _controllerCodeBar.text,
              cantidad: int.parse(_controllerCantidad.text),
              orden: 1,
              estado: 'B',
              fechahora: DateTime.now().toString(),
              transmitido: 'N',
              fhTransmitido: '');

          //

          //socketService.socket.emit('add-cantidad', {'id': '1'});

          setState(() {
            _controllerCodeBar.text = '';
            _controllerCantidad.text = '1';

            //FocusScope.of(context).unfocus();
            //SystemChannels.textInput.invokeMethod('TextInput.hide');

            FocusScope.of(context).requestFocus(codeBarField);

            //FocusScope.of(context).focusedChild.unfocus();

            print('Longitud ${_lLecturas.length}');
            _lLecturas.add(lectura1);

            //Future<int> res = DBProvider.db.nuevoScan(lectura1);
            Future<int> res = DBProvider.db.nuevoScan2(lectura1, socketService);
            print('Inserto2: $res');

            // res.then((value) {
            //   lectura.id = value;
            //   _lLecturas.add(lectura);
            // });
          });
        }
      },
    );
  }

  Widget _crearArea(context) {
    return TextField(
      controller: _controllerArea,
      focusNode: areaField,
      decoration: InputDecoration(
        hintText: 'Area de Contador',
        labelText: 'Area de Conteo',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSubmitted: (valor) {
        _nombre = valor;
        print('Area: $_nombre');
        setState(() {
          _controllerArea.text.isEmpty
              ? FocusScope.of(context).requestFocus(areaField)
              : FocusScope.of(context).requestFocus(conteoField);
        });
      },
    );
  }

  Widget _crearConteo(context) {
    return TextField(
      controller: _controllerConteo,
      focusNode: conteoField,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Conteo',
        labelText: 'Conteo',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSubmitted: (valor) {
        _nombre = valor;
        print(_nombre);
        setState(() {
          _controllerConteo.text.isEmpty
              ? FocusScope.of(context).requestFocus(conteoField)
              : FocusScope.of(context).requestFocus(cantidadField);
        });
      },
    );
  }

  Widget _crearTotal() {
    return TextFormField(
      enabled: false,
      initialValue: '0',
      decoration: InputDecoration(
        hintText: 'Total Area',
        labelText: 'Total Area',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        _nombre = valor;
        print(_nombre);
        setState(() {});
      },
    );
  }

  Widget _crearCantidad(context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cantidad a leer',
        labelText: 'Cantidad a leer',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      controller: _controllerCantidad,
      focusNode: cantidadField,
      keyboardType: TextInputType.number,
      onSubmitted: (value) {
        print('$value');
        //setState(() {
        //_controllerCodeBar.text = '';
        //});
        _controllerCantidad.text.isEmpty
            ? FocusScope.of(context).requestFocus(cantidadField)
            : FocusScope.of(context).requestFocus(codeBarField);
      },
    );
  }

  Widget _crearFlotantes() {
    return Row(
      children: <Widget>[
        SizedBox(width: 30.0),
        FloatingActionButton(onPressed: null, child: Icon(Icons.camera_alt)),
        SizedBox(width: 10.0),
        FloatingActionButton(onPressed: null, child: Icon(Icons.qr_code)),
        Expanded(child: SizedBox()),
        FloatingActionButton(onPressed: null, child: Text('Menu'))
      ],
    );
  }

  Widget _crearLectura(Lectura lectura, int index) {
    final socketService = Provider.of<SocketService>(context);

    return Dismissible(
      key: Key('A${lectura.rowid}'),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TODO REMOVER DE LA BASE DE DATOS
        print('A remover rowid: ${lectura.rowid}');
        print('A remover id:${lectura.id}');

        //_lLecturas.removeAt(index);

        setState(() {
          //DBProvider.db.deleteScan(lectura.rowid);
          DBProvider.db.deleteScan2(lectura.rowid, socketService);
        });
      },
      child: ListTile(
        leading: Text('${lectura.orden}'),
        title: Text('${lectura.barCode}'),
        trailing: Text('${lectura.cantidad}'),
        onTap: () {
          print('on Tap barcode: ${lectura.barCode}');
          print('on Tap rowid: ${lectura.rowid}');
          print('on Tap id: ${lectura.id}');
          print(index);
        },
      ),
    );
  }

  Widget _crearLecturas(context) {
    return ListView.builder(
      reverse: true,
      itemCount: _lLecturas.length,
      controller: null,
      itemBuilder: (context, index) => _crearLectura(_lLecturas[index], index),
    );
  }

  Widget _crearLecturasDB(context) {
    return FutureBuilder<List<Lectura>>(
      future: DBProvider.db.getTodoScanRaw(),
      builder: (context, AsyncSnapshot<List<Lectura>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text('No hay datos'),
          );
        }

        return ListView.builder(
          reverse: true,
          itemCount: scans.length,
          itemBuilder: (context, index) => _crearLectura(scans[index], index),
        );
      },
    );
  }
}
