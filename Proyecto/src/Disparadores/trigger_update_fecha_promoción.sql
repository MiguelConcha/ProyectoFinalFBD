-- ##########################################################################
-- Nombre            : trigger_hist�rico.sql.
-- Fecha             : 12 de enero del 2018.
-- Autores           : Flores Mart�nez Andr�s, 
--                     V�zquez Salcedo Eduardo Eder,
--                     S�nchez P�rez Pedro Juan Salvador,
--                     Concha V�zquez Miguel.
-- Compa��a          : Comput�logos A.C., Facultad de Ciencias UNAM.
-- Cliente           : Taquer�a Tacoste.
-- ========================================================================
-- Prop�sito         : Se crea un disparador debido a que deseamos que 
--                     dependiendo del d�a de la semana que se hace una compra,
--                     se determine la promoci�n de la misma.
-- ##########################################################################

create or replace trigger update_fecha_promocion
after insert or update of fechaPedido on pedido
for each row
declare
	dia varchar2(15); -- Variable donde almacenaremos el d�a de la semana de la fecha agregada.
    date_already_in number(1);
begin
    select count(*) into date_already_in from fechaPedPromo where fechaPedido = :new.fechaPedido;
    if date_already_in = 0 then
        dia := replace(to_char(:new.fechaPedido, 'Day'),' ',''); -- Calculamos el d�a de la fecha ingresada quitando espacios a la derecha.
        -- Dependiendo del d�a es la promoci�n que almacenaremos en la respectiva tabla.
        if dia = 'Jueves' then
            insert into fechaPedPromo(fechaPedido, promocion) values(:new.fechaPedido, 'JUEVES POZOLERO');
        elsif dia = 'Viernes' then
            insert into fechaPedPromo(fechaPedido, promocion) values(:new.fechaPedido, 'TACO AMIGO');
        elsif dia = 'Martes' then
            insert into fechaPedPromo(fechaPedido, promocion) values(:new.fechaPedido, 'MARTES DE TORTUGA');
        else 
            insert into fechaPedPromo(fechaPedido, promocion) values(:new.fechaPedido, 'NINGUNA');
        end if;
    end if;
end;

-- Ejemplos:
/*
INSERT INTO SUCURSAL(IDSUCURSAL, HORAAPERTURA, HORACIERRE, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR) VALUES
(600000, TO_TIMESTAMP ('10-Sep-02 11:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),TO_TIMESTAMP ('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'), 'Elkland', 'Fakenham', '1954 Monument Road', 0, 95, 3914);
INSERT INTO CLIENTE(TAQUICLAVE, EMAIL, TELEFONO, NOMBRE, APELLIDOPATERNO, APELLIDOMATERNO, MUNICIPIO, COLONIA, CALLE, CP, NUMINTERIOR, NUMEXTERIOR, FECHAPRIMERVISTA, NUMPUNTOS) VALUES
(70000000161, 'RhonaArriaga71@example.com', '(342) 816-0981', 'Avelina', 'Mccray', 'Laster', 'Medical Lake', 'Bristol', '96 Glenwood Pkwy', 25, 22, 1876, TO_DATE('07/03/1986','dd/mm/yyyy'), 0);
INSERT INTO PEDIDO(NUMPEDIDO, IDSUCURSAL, FECHAPEDIDO, TAQUICLAVE, METODOPAGO) VALUES
(8000001, 600000, TO_DATE('06/01/2006','dd/mm/yyyy'), 70000000161, 'EFECTIVO');
select * from fechaPedPromo; --debería ser viernes, con promoción taco amigo 
*/