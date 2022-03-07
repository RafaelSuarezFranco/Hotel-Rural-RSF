# Hotel-Rural-RSF

Un programa para administrar las reservas y ocupaciones de un hotel, incluyendo detalles como las temporadas, clientes, precios, servicios, etc. Los componentes del programa
se generan dinámicamente a partir de los datos almacenados del hotel, por lo que si dicho hotel se amplía (más habitaciones, más servicios, etc), el programa contempla esa 
posibilidad.


<h2>Funcionalidades del programa</h2>

<h3>Pantalla principal</h3>

- Visualizar el estado de las habitaciones día por día.
- Cambiar el estado de una habitación para un día concreto.
- Reservar un periodo concreto.
- Anular reservas y ocupaciones de un periodo concreto.
- Crear nuevas temporadas.
- Crear nuevas habitaciones.
- Crear nuevos servicios.
- Crear informes.
- Crear gráficos.
- Acceder a la vista mensual de una habitación.

![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/principal.png)

![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/nuevahabitacion.png) ![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/creartemporada.png)
![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/altaservicio.png)
<h3>Pantalla mensual</h3>

- Visualizar el estado de una habitación mes a mes.
- Cambiar el estado de una habitación para un día concreto.
![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/pantallames.png)

<h3>Formularios de reserva</h3>

- Dar de alta nuevos clientes
- Gestionar los servicios de las habitaciones (se pueden contratar al reservar por periodo o elegir la habitación y días concretos en los que contratarlos indivdualmente).
- Cambiar el precio final que tendrá la habitación para un día concreto, independientemente de la temporada o servicios contratados.
- Gestionar el estado de las habitaciones, siguiendo las reglas del siguiente apartado.

![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/formulariodiario.png) ![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/formularioperiodo.png)

![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/altacliente.png)

<h3>Informes</h3>

Podemos generar los siguientes tipos de informes en PDF:
- Factura: Reservas/ocupaciones para un periodo y habitación concretos, incluyendo servicios.
- Itinerario de Servicios: Imprime una lista de habitaciones que tienen contratados ciertos servicios para un día concreto.
- Clientes: Muestra un listado de clientes.
- Historial de cliente: Muestra todas las reservas y ocupaciones realizadas por un cliente concreto, incluyendo servicios.
- Informe dinámico: Permite realizar un informe sobre cualquier tabla de la base de datos, eligiendo los campos a mostrar.

![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/facturaparametros.png)
![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/factura.png)
![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/itinerario.png)

<h3>Gráficos</h3>

- Ingresos por reservas: Muestra los ingresos de las reservas u ocupaciones entre dos fechas concretas. También muestra la cantidad de habitaciones reservadas/ocupadas.
- Ingresos por servicios: Muestra los ingresos generados por todos los servicios para reservas u ocupaciones entre dos fechas concretas, de una habitación concreta o de todas.

![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/graficoreservas.png)
![alt text](https://github.com/RafaelSuarezFranco/Hotel-Rural-RSF/blob/main/Capturas%20hotel/graficoservicios.png)

<h2>Reglas establecidas en cuanto a cambios de estado de habitaciones.</h2>

Reservar/anular por periodos: solo se pueden hacer en días futuros, incluyendo el día de hoy. Anular tambíen anula ocupaciones.

Por días:
- De libre a reservada : Día de hoy o futuro.
- De libre a ocupada : Día de hoy o en los 7 días pasados.
- De reservada a ocupada: Día de hoy o en el pasado
- De reservada a libre : Cualquier día.
- De ocupada a libre : Día de hoy (o futuro, pero no se puede marcar como ocupado en el futuro).
- De ocupada a reservada: Nunca.

<h3>Colores</h3>

Utilizamos distintos colores para distinguir a simple vista el estado de las habitaciones:

- ![#FF0000](https://via.placeholder.com/15/FF0000/000000?text=+) `Rojo` 'clRed': ocupado.
- ![#FFFF00](https://via.placeholder.com/15/FFFF00/000000?text=+) `Amarillo` 'clyellow': reservado.
- ![#7cfc00](https://via.placeholder.com/15/7cfc00/000000?text=+) `Verde césped` 'clWebLawnGreen': libre - temporada baja.
- ![#32cd32](https://via.placeholder.com/15/32cd32/000000?text=+) `Verde lima` 'clWebLimeGreen' (algo más oscuro que el anterior): libre - temporada media.
- ![#228b22](https://via.placeholder.com/15/228b22/000000?text=+) `Verde bosque` 'clWebForestGreen' (más oscuro que los anteriores): libre - temporada alta.
