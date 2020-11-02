class Lectura {
  int area;
  int orden;
  int conteo;
  int cantidad = 1;

  String id;
  String estado;
  String contador;
  String barCode = '';
  String transmitido = 'F';

  String fechahora;
  String fhTransmitido;

  Lectura({
    this.id,
    this.area,
    this.conteo,
    this.contador,
    this.barCode,
    this.cantidad,
    this.orden,
    this.estado,
    this.fechahora,
    this.transmitido,
    this.fhTransmitido,
  });

  factory Lectura.fromJson(Map<String, dynamic> json) => Lectura(
        id: json["id"],
        area: json["area"],
        conteo: json["conteo"],
        contador: json["contador"],
        barCode: json["barCode"],
        cantidad: json["cantidad"],
        orden: json["orden"],
        estado: json["estado"],
        fechahora: json["fechahora"],
        transmitido: json["transmitido"],
        fhTransmitido: json["fhTransmitido"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "conteo": conteo,
        "contador": contador,
        "barCode": barCode,
        "cantidad": cantidad,
        "orden": orden,
        "estado": estado,
        "fechahora": fechahora,
        "transmitido": transmitido,
        "fhTransmitido": fhTransmitido,
      };
}
