USE Empleados;
-- 1. Obtener los datos completos de los empleados.

SELECT * FROM Empleado;

-- 2. Obtener los datos completos de los departamentos

SELECT * FROM Departamento;

-- 3. Obtener los datos de los empleados con cargo 'Secretaria'.

SELECT * FROM Empleado WHERE cargoE = 'Secretaria';

-- 4. Obtener el nombre y salario de los empleados.

SELECT nomEmp, salEmp FROM Empleado;

-- 5. Obtener los datos de los empleados vendedores, ordenado por nombre.

SELECT * FROM Empleado WHERE cargoE = 'Vendedor' ORDER BY nomEmp;

-- 6. Listar el nombre de los departamentos

SELECT DISTINCT nombreDpto FROM Departamento;

-- 7. Listar el nombre de los departamentos, ordenado por nombre

SELECT DISTINCT nombreDpto FROM Departamento;

-- 8. Listar el nombre de los departamentos, ordenado por ciudad

SELECT nombreDpto, ciudad FROM Departamento ORDER BY ciudad;

-- 9. Listar el nombre de los departamentos, ordenado por ciudad, en orden inverso

SELECT nombreDpto, ciudad FROM Departamento ORDER BY ciudad DESC;

-- 10. Obtener el nombre y cargo de todos los empleados, ordenado por salario

SELECT nomEmp, cargoE, salEmp FROM Empleado ORDER BY salEmp;

-- 11. Obtener el nombre y cargo de todos los empleados, ordenado por cargo y por salario

SELECT nomEmp, cargoE, salEmp FROM Empleado ORDER BY cargoE, salEmp;

-- 12. Obtener el nombre y cargo de todos los empleados, en orden inverso por cargo

SELECT nomEmp, cargoE FROM Empleado ORDER BY cargoE DESC;

-- 13. Listar los salarios y comisiones de los empleados del departamento 2000

SELECT nomEmp, salEmp, comisionE FROM Empleado WHERE codDepto = 2000;

-- 14. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisi�n

SELECT nomEmp, salEmp, comisionE FROM Empleado WHERE codDepto = 2000 ORDER BY comisionE;

-- 15. Listar todas las comisiones

SELECT nomEmp, comisionE FROM Empleado;

-- 16. Listar las comisiones que sean diferentes, ordenada por valor

SELECT DISTINCT comisionE FROM Empleado ORDER BY comisionE;

-- 17. Listar los diferentes salarios

SELECT DISTINCT salEmp FROM Empleado;

/* 18. Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una
bonificaci�n de $500.000, en orden alfab�tico del empleado */



-- 19. Obtener la lista de los empleados que ganan una comisi�n superior a su sueldo.

SELECT nomEmp, salEmp, comisionE FROM Empleado WHERE comisionE > salEmp;

-- 20. Listar los empleados cuya comisi�n es menor o igual que el 30% de su sueldo.

SELECT nomEmp, salEmp, comisionE FROM Empleado WHERE comisionE <= salEmp*0.3;

/* 21. Elabore un listado donde para cada fila, figure �Nombre� y �Cargo� antes del valor respectivo para
cada empleado */

SELECT 'Nombre' , nomEmp, 'Cargo', cargoE  FROM Empleado;

SELECT 'Nombre: ' + nomEmp, 'Cargo: ' + cargoE  FROM Empleado;

/* 22. Hallar el salario y la comisi�n de aquellos empleados cuyo n�mero de documento de identidad es
superior al '19.709.802'*/

SELECT CAST(REPLACE(nDIEmp,'.','') AS INT) AS dni, salEmp, comisionE
FROM Empleado WHERE CAST(REPLACE(nDIEmp,'.','') AS INT) > 19709802
ORDER BY dni;
  
-- 23. Listar los empleados cuyo salario es menor o igual que el 40% de su comisi�n

SELECT nomEmp, salEmp, comisionE FROM Empleado WHERE salEmp  <= comisionE*0.4;

/*24. Divida los empleados, generando un grupo cuyo nombre inicie por la letra J y termine en la letra Z.
Liste estos empleados y su cargo por orden alfab�tico. */

SELECT nomEmp, cargoE FROM Empleado WHERE nomEmp LIKE 'J%z' ORDER BY nomEmp;

/* 25. Listar el salario, la comisi�n, el salario total (salario + comisi�n), documento de identidad del
empleado y nombre, de aquellos empleados que tienen comisi�n superior a $1.000.000, ordenar el
informe por el n�mero del documento de identidad */

SELECT CAST(REPLACE(nDIEmp,'.','') AS INT) AS dni, salEmp, comisionE, (salEmp + comisionE) as 'Salario Total'
FROM Empleado WHERE comisionE > 1000000
ORDER BY dni;

-- 26. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisi�n

SELECT CAST(REPLACE(nDIEmp,'.','') AS INT) AS dni, salEmp, comisionE, (salEmp + comisionE) as 'Salario Total'
FROM Empleado WHERE comisionE = 0
ORDER BY dni;

/* 27. Hallar el nombre de los empleados que tienen un salario superior a $1.000.000, y tienen como jefe al
empleado con documento de identidad '31.840.269' */

SELECT nomEmp FROM Empleado WHERE salEmp > 1000000 AND jefeID = '31.840.269';

-- 28. Hallar el conjunto complementario del resultado del ejercicio anterior.

SELECT nomEmp FROM Empleado WHERE salEmp <= 1000000 OR jefeID <> '31.840.269' OR jefeID IS NULL;

-- 29. Hallar los empleados cuyo nombre no contiene la cadena �MA�

SELECT nomEmp FROM Empleado WHERE nomEmp NOT LIKE '%MA%';

/* 30. Obtener los nombres de los departamentos que no sean �Ventas� ni �Investigaci�n� NI
�MANTENIMIENTO�, ordenados por ciudad. */

SELECT nombreDpto, ciudad FROM Departamento WHERE nombreDpto NOT IN ('ventas','Investigaci�n','MANTENIMIENTO');

/* 31. Obtener el nombre y el departamento de los empleados con cargo 'Secretaria' o 'Vendedor', que
no trabajan en el departamento de �PRODUCCION�, cuyo salario es superior a $1.000.000,
ordenados por fecha de incorporaci�n. */

SELECT nomEmp, nombreDpto FROM Empleado e INNER JOIN Departamento d ON e.codDepto = d.codDepto
WHERE cargoE IN ('Secretaria','Vendedor') AND nombreDpto <> 'PRODUCCI�N' AND salEmp > 1000000
ORDER BY fecIncorporacion;

-- 32. Obtener informaci�n de los empleados cuyo nombre tiene exactamente 11 caracteres

SELECT * FROM Empleado WHERE LEN(nomEmp) = 11;


-- 33. Obtener informaci�n de los empleados cuyo nombre tiene al menos 11 caracteres

SELECT * FROM Empleado WHERE LEN(nomEmp) >= 11;

/* 34. Listar los datos de los empleados cuyo nombre inicia por la letra 'M', su salario es mayor a $800.000
o reciben comisi�n y trabajan para el departamento de 'VENTAS' */

SELECT * FROM Empleado e INNER JOIN Departamento d ON e.codDepto = d.codDepto
WHERE nomEmp LIKE 'M%' AND (salEmp > 800000 OR comisionE <> 0)
AND d.nombreDpto = 'VENTAS';

/* 35. Obtener los nombres, salarios y comisiones de los empleados que reciben un salario situado entre la
mitad de la comisi�n la propia comisi�n */



/* 36. Suponga que la empresa va a aplicar un reajuste salarial del 7%. Listar los nombres de los empleados, su
salario actual y su nuevo salario, indicando para cada uno de ellos si tiene o no comisi�n */

SELECT nomEmp, salEmp, (salEmp * 1.07) 'Salario + 7%',
(SELECT CASE comisionE
WHEN 0 THEN 'No'
ELSE 'Si'
END AS TieneComision
) AS 'Tiene Comisi�n'
FROM Empleado;

/* 37. Obtener la informaci�n disponible del empleado cuyo n�mero de documento de identidad sea:
'31.178.144', '16.759.060', '1.751.219', '768.782', '737.689', '19.709.802', '31.174.099', '1.130.782' */

SELECT * FROM Empleado
WHERE nDIEmp IN ('31.178.144', '16.759.060', '1.751.219', '768.782', '737.689', '19.709.802', '31.174.099', '1.130.782');

/* 38. Entregar un listado de todos los empleados ordenado por su departamento, y alfab�tico dentro del
departamento. */

SELECT * FROM Empleado e INNER JOIN Departamento d ON e.codDepto = d.codDepto
ORDER BY nombreDpto, nomEmp;

-- 39. Entregar el salario m�s alto de la empresa. 

SELECT MAX(salEmp) FROM Empleado;

-- 40. Entregar el total a pagar por comisiones, y el n�mero de empleados que las reciben.

SELECT SUM(comisionE) 'Comisiones', COUNT(*) 'N�mero de empleados con comisi�n'
FROM Empleado WHERE comisionE <> 0;

-- 41. Entregar el nombre del �ltimo empleado de la lista por orden alfab�tico.

SELECT TOP 1 nomEmp FROM Empleado ORDER BY nomEmp DESC;

-- 42. Hallar el salario m�s alto, el m�s bajo y la diferencia entre ellos.

SELECT MAX(salEmp) 'M�ximo', MIN(salEmp) 'M�nimo', MAX(salEmp) - MIN(salEmp) 'Diferencia'
FROM Empleado;

/*43. Conocido el resultado anterior, entregar el nombre de los empleados que reciben el salario m�s alto
y m�s bajo. Cuanto suman estos salarios? */




/*

SELECT TOP 2 nomEmp, salEmp,
(SELECT CASE salEmp
WHEN MAX(salEmp) THEN salEmp
WHEN MIN(salEmp) THEN salEmp
ELSE 0
END AS Salario
) AS 'Salario'
FROM Empleado
ORDER BY 'Salario'
;

SELECT * FROM Empleado WHERE salEmp = MAX(salEmp);

SELECT * FROM Empleado HAVING salEmp = MAX(salEmp);

*************************************************************************************************/

SELECT MAX (salEmp), MIN (salEmp), 
 (MAX (salEmp) + MIN (salEmp))
FROM Empleado;

-- 44. Entregar el n�mero de empleados de sexo femenino y de sexo masculino, por departamento.

SELECT COUNT(*), sexEmp FROM Empleado GROUP BY sexEmp;

-- 45. Hallar el salario promedio por departamento.

SELECT codDepto, AVG(salEmp) 'Salario medio' FROM Empleado GROUP BY codDepto;

/* 46. Hallar el salario promedio por departamento, considerando aquellos empleados cuyo salario supera
$900.000, y aquellos con salarios inferiores a $575.000. Entregar el c�digo y el nombre del
departamento. */

SELECT N.codDepto, D.nombreDpto, N.pro
FROM Departamento D, 
 (SELECT codDepto, AVG(salEmp) AS pro
 FROM Empleado 
 WHERE salEmp > 900000 OR
 salEmp < 575000
 GROUP BY codDepto) N
WHERE N.codDepto = D.codDepto;


/**********************************************
SELECT e.codDepto, nombreDpto, AVG(salEmp) 'Salario medio' FROM Empleado e RIGHT JOIN Departamento d
ON e.codDepto = d.codDepto
WHERE salEmp > 900000 OR salEmp < 575000

GROUP BY e.codDepto
;
***************************************************/

/* 47. Entregar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa.
Ordenarlo por departamento. */



/* 48. Hallar los departamentos que tienen m�s de tres (3) empleados. Entregar el n�mero de empleados de
esos departamentos.
49. Obtener la lista de empleados jefes, que tienen al menos un empleado a su cargo. Ordene el informe
inversamente por el nombre.
50. Hallar los departamentos que no tienen empleados
51. Entregar un reporte con el numero de cargos en cada departamento y cual es el promedio de salario
de cada uno. Indique el nombre del departamento en el resultado.
52. Entregar el nombre del departamento cuya suma de salarios sea la m�s alta, indicando el valor de la
suma.
53. Entregar un reporte con el c�digo y nombre de cada jefe, junto al n�mero de empleados que dirige.
Puede haber empleados que no tengan supervisores, para esto se indicar� solamente el numero de
ellos dejando los valores restantes en NULL.*/