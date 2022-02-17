# Hotel-Rural-RSF

Un programa para administrar las reservas y ocupaciones de un hotel, incluyendo detalles como las temporadas, clientes, precios, servicios, etc. Los componentes del programa
se generan dinámicamente a partir de los datos almacenados del hotel, por lo que si dicho hotel se amplía (más habitaciones, más servicios, etc), el programa contempla esa 
posibilidad.


<h2>Funcionalidades del programa</h2>

<h3>Pantalla principal</h3>

- Visualizar el estado de las habitaciones día por día.
- Cambiar el estado de una habitación para un día concreto.
- Crear nuevas habitaciones.
- Reservar un periodo concreto.
- Anular reservas y ocupaciones de un periodo concreto.
- Crear nuevas temporadas.
- Acceder a la vista mensual de una habitación.


<h3>Pantalla mensual</h3>

- Visualizar el estado de una habitación mes a mes.
- Cambiar el estado de una habitación para un día concreto.

<h3>Formularios de reserva</h3>

- Dar de alta nuevos clientes
- Gestionar los servicios de las habitaciones (se pueden contratar al reservar por periodo o elegir la habitación y días concretos en los que contratarlos indivdualmente).
- Cambiar el precio final que tendrá la habitación para un día concreto, independientemente de la temporada o servicios contratados.
- Gestionar el estado de las habitaciones, siguiendo las reglas del siguiente apartado.


<h2>Reglas establecidas en cuanto a cambios de estado de habitaciones.</h2>

Reservar/anular por periodos: solo se pueden hacer en días futuros, incluyendo el día de hoy. Anular tambíen anula ocupaciones.

Por días:
- De libre a reservada : Día de hoy o futuro.
- De libre a ocupada : Día de hoy o en los 7 días pasados.
- De reservada a ocupada: Día de hoy o en el pasado
- De reservada a libre : Cualquier día.
- De ocupada a libre : Día de hoy (o futuro, pero no se puede marcar como ocupado en el futuro).
- De ocupada a reservada: Nunca.
