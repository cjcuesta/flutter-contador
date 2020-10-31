import 'package:contador/models/lectura_model.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/form.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  var firstField = FocusNode();
  var secondField = FocusNode();

  Lectura lectura = Lectura();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(context),
                _crearPrecio(context),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) {
        print('$value');
        //setState(() {
        _controller.text = '';
        //});
        FocusScope.of(context).requestFocus(firstField);
      },
      controller: _controller,
      focusNode: firstField,
      initialValue: lectura.barCode,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      validator: (value) {
        if (value.isEmpty) {
          print('Esta vacio');
          return 'Esta vacio';
        }
        print('$value');
        return value;
      },
    );
  }

  Widget _crearPrecio(BuildContext context) {
    return TextFormField(
      focusNode: secondField,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      validator: (value) {
        return 'vacio';
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: _submit,
    );
  }

  void _submit() {
    formKey.currentState.validate();
  }
}
