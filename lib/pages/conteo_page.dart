import 'package:contador/models/lectura_model.dart';
import 'package:flutter/material.dart';

class ConteoPage extends StatefulWidget {
  @override
  _ConteoPageState createState() => _ConteoPageState();
}

class _ConteoPageState extends State<ConteoPage> {
  final _controllerArea = TextEditingController();
  final _controllerConteo = TextEditingController();
  final _controllerCodeBar = TextEditingController();
  final _controllerCantidad = TextEditingController();

  var codeBarField = FocusNode();
  var cantidadField = FocusNode();

  String _nombre = '';

  List<Lectura> _lLecturas = [
    Lectura(
        id: '1',
        area: 1,
        conteo: 1,
        contador: '1111',
        barCode: '1111111',
        cantidad: 1,
        orden: 1,
        estado: 'B',
        fechahora: '',
        transmitido: 'N',
        fhTransmitido: ''),
    Lectura(
        id: '2',
        area: 1,
        conteo: 1,
        contador: '1111',
        barCode: '2222222',
        cantidad: 1,
        orden: 2,
        estado: 'B',
        fechahora: '',
        transmitido: 'N',
        fhTransmitido: ''),
    Lectura(
        id: '3',
        area: 1,
        conteo: 1,
        contador: '1111',
        barCode: '3333333',
        cantidad: 1,
        orden: 3,
        estado: 'B',
        fechahora: '',
        transmitido: 'N',
        fhTransmitido: ''),
    Lectura(
        id: '4',
        area: 1,
        conteo: 1,
        contador: '1111',
        barCode: '4444444',
        cantidad: 1,
        orden: 4,
        estado: 'B',
        fechahora: '',
        transmitido: 'N',
        fhTransmitido: ''),
    Lectura(
        id: '5',
        area: 1,
        conteo: 1,
        contador: '1111',
        barCode: '5555555',
        cantidad: 1,
        orden: 5,
        estado: 'B',
        fechahora: '',
        transmitido: 'N',
        fhTransmitido: ''),
    Lectura(
        id: '6',
        area: 1,
        conteo: 1,
        contador: '1111',
        barCode: '6666666',
        cantidad: 1,
        orden: 5,
        estado: 'B',
        fechahora: '',
        transmitido: 'N',
        fhTransmitido: '')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: //_crearLecturas(context),
          Column(
//        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearArea(),
          Divider(),
          _crearConteo(),
          Divider(),
          _crearTotal(),
          Divider(),
          _crearCantidad(context),
          Divider(),
          _crearInput(context),
          Divider(),
          Expanded(child: _crearLecturas(context)),
        ],
      ),
      //  floatingActionButton: _crearFlotantes(),
    );
  }

  Widget _crearInput(BuildContext context) {
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
        setState(() {
          _lLecturas.add(Lectura(
              id: '${_lLecturas.length}',
              area: int.parse(_controllerArea.text),
              conteo: int.parse(_controllerConteo.text),
              contador: '1111',
              barCode: _controllerCodeBar.text,
              cantidad: int.parse(_controllerCantidad.text),
              orden: 1,
              estado: 'B',
              fechahora: DateTime.now().toString(),
              transmitido: 'N',
              fhTransmitido: ''));

          _controllerCodeBar.text = '';
          _controllerCantidad.text = '1';
        });
        FocusScope.of(context).requestFocus(codeBarField);
      },
    );
  }

  Widget _crearArea() {
    return TextField(
      controller: _controllerArea,
      decoration: InputDecoration(
        hintText: 'Area de Contador',
        labelText: 'Area de Conteo',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        _nombre = valor;
        print(_nombre);
        setState(() {});
      },
    );
  }

  Widget _crearConteo() {
    return TextField(
      controller: _controllerConteo,
      decoration: InputDecoration(
        hintText: 'Conteo',
        labelText: 'Conteo',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onChanged: (valor) {
        _nombre = valor;
        print(_nombre);
        setState(() {});
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
      onSubmitted: (value) {
        print('$value');
        //setState(() {
        //_controllerCodeBar.text = '';
        //});
        FocusScope.of(context).requestFocus(codeBarField);
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
    return Dismissible(
      key: Key(lectura.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TODO REMOVER DE LA BASE DE DATOS
        _lLecturas.removeAt(index);
        setState(() {});
      },
      child: ListTile(
        leading: Text('${lectura.orden}'),
        title: Text('${lectura.barCode}'),
        trailing: Text('${lectura.cantidad}'),
        onTap: () {
          print(lectura.barCode);
          print(index);
        },
      ),
    );
  }

  Widget _crearLecturas(context) {
    return ListView.builder(
      reverse: true,
      itemCount: _lLecturas.length,
      itemBuilder: (context, index) => _crearLectura(_lLecturas[index], index),
    );
  }
}
