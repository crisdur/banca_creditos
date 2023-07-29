import 'package:intl/intl.dart';

String formatCash(String numeroString) {
  // Convertir el string a un número
  double numero = double.tryParse(numeroString) ?? 0.0;

  // Redondear el número a dos decimales
  numero = double.parse(numero.toStringAsFixed(2));

  // Definir el formato para los separadores de miles y decimales
  var formato = NumberFormat("#,##0.00", "en_US");
  // Aplicar el formato al número
  String numeroFormateado = formato.format(numero);
  // Reemplazar los separadores predeterminados (',' y '.') con los deseados ("'" y ',')
  numeroFormateado = numeroFormateado.replaceAll(',', "'").replaceAll('.', ",");
  // Agregar el símbolo del dólar al inicio
  numeroFormateado = "\$ " + numeroFormateado;
  return numeroFormateado;
}
