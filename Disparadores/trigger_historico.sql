--creamos una secuencia para la llave de cada tupla del histórico
create sequence hist_seq start with 1;

delete trigger dept_bir;
--creamos disparador para almacenar la informacion necesaria en el historico
create or replace trigger actualiza_historico
after insert or update on producto
for each row
declare
	new_idHistorico;
begin
    select hist_seq.nextval
    into new_idHistorico
    from dual; 
	insert into historico(idHistorico, idProducto, fechaActualizacion, precioNuevo)
	               values(new_idHistorico, :new.idProducto, current_date,:new.precio);
	insert into conservar(idHistorico, idProducto) 
		           values(new_idHistorico, :new.idProducto);
end;

/*
INSERT INTO PRODUCTO(IDPRODUCTO, PUNTOSOTORGAR, NOMBRE, PRECIO, TAQUEGORIA) VALUES
(15, 38039, 'Monjectry', 5, 'QUECAS');
select * from historico;
INSERT INTO PEDIDO(NUMPEDIDO, IDSUCURSAL, FECHAPEDIDO, TAQUICLAVE, METODOPAGO) VALUES
(1, 1, TO_DATE('07/03/1986','dd/mm/yyyy'), 7000000016, 'EFECTIVO');
select * from cliente
INSERT INTO CONTENER(NUMPEDIDO, IDPRODUCTO, CANTIDAD) VALUES
(1, 15, 5);
*/