CREATE DATABASE QUETZAL_EXPRESS;

USE QUETZAL_EXPRESS; 

CREATE TABLE PAIS(
	id_pais int NOT NULL IDENTITY(1,1),
	nombre	varchar(50) NOT NULL,
	PRIMARY KEY (id_pais)
);

CREATE TABLE SUCURSAL(
	id_sucursal int NOT NULL IDENTITY(1,1),
	nombre	varchar(50) NOT NULL,
	direccion	varchar(50) NOT NULL,
	telefono	varchar(20) NOT NULL,
	no_empleados	int	NOT NULL,
	id_pais	int	NOT NULL,
	FOREIGN KEY(id_pais) REFERENCES PAIS(id_pais),
	PRIMARY KEY (id_sucursal)
);

CREATE TABLE TIPO_USUARIO(
	id_tipo int NOT NULL IDENTITY(1,1),
	nombre	varchar(50) NOT NULL,
	PRIMARY KEY (id_tipo)
);

CREATE TABLE USUARIO(
	id_usuario int NOT NULL IDENTITY(1,1),
	dpi	varchar(15) NOT NULL,
	nombre	varchar(50) NOT NULL,
	apellido	varchar(50) NOT NULL,
	nit	varchar(25) NOT NULL,
	telefono	varchar(20) NOT NULL,
	contasenia	varchar(50) NOT NULL,
	direccion	varchar(50) NOT NULL,
	tarjeta	varchar(25) NOT NULL,
	sueldo	real	NOT NULL,
	activo bit	NOT NULL,
	id_sucursal	int	NOT NULL,
	tipo_usuario int NOT NULL,
	FOREIGN KEY(id_sucursal) REFERENCES SUCURSAL(id_sucursal),
	FOREIGN KEY(tipo_usuario) REFERENCES TIPO_USUARIO(id_tipo),
	PRIMARY KEY (id_usuario)
);

CREATE TABLE CASILLA(
	id_casilla int NOT NULL IDENTITY(1,1),
	id_usuario	int NOT NULL,
	FOREIGN KEY(id_usuario) REFERENCES USUARIO(id_usuario),
	PRIMARY KEY(id_casilla,id_usuario)
);

CREATE TABLE LOTE(
	id_lote	int NOT NULL IDENTITY(1,1),
	fecha	date	NOT NULL,
	estado int	NOT NULL,
	PRIMARY KEY(id_lote)
);

CREATE TABLE DEPARTAMENTO(
	id_departamento	int NOT NULL IDENTITY(1,1),
	nombre	varchar(50)	NOT NULL,
	PRIMARY KEY(id_departamento)
);

CREATE TABLE SUCURSAL_DEPARTAMENTO(
	id_departamento	int NOT NULL,
	id_sucursal	int	NOT NULL,
	FOREIGN KEY(id_departamento) REFERENCES DEPARTAMENTO(id_departamento),
	FOREIGN KEY(id_sucursal) REFERENCES SUCURSAL(id_sucursal),
	PRIMARY KEY(id_departamento, id_sucursal)
);

CREATE TABLE COBRO(
	id_cobro	int	NOT NULL IDENTITY(1,1),
	nombre	varchar(50)	NOT NULL,
	porcentaje	real	NOT NULL,
	valor	real	NOT NULL,
	activo	bit	NOT NULL,
	PRIMARY KEY(id_cobro)	
);

CREATE TABLE IMPUESTO(
	id_impuesto	int	NOT NULL IDENTITY(1,1),
	nombre	varchar(50)	NOT NULL,
	porcentaje	real	NOT NULL,
	activo	bit	NOT NULL,
	PRIMARY KEY(id_impuesto)	
);

CREATE TABLE PAQUETE(
	id_paquete	int	NOT NULL IDENTITY(1,1),
	descripcion	varchar(50)	NOT NULL,
	peso	int	NOT NULL,
	precio	real	NOT NULL,
	perdido	bit	NOT NULL,
	id_lote	int NOT NULL,
	id_impuesto	int	NOT NULL,
	id_cobro	int NOT NULL,
	id_casilla	int	NOT NULL,
	id_usuario	int	NOT NULL,
	FOREIGN KEY(id_lote) REFERENCES LOTE(id_lote),
	FOREIGN KEY(id_impuesto) REFERENCES IMPUESTO(id_impuesto),
	FOREIGN KEY(id_cobro) REFERENCES COBRO(id_cobro),
	FOREIGN KEY(id_casilla, id_usuario) REFERENCES CASILLA(id_casilla, id_usuario),
	PRIMARY KEY(id_paquete)
);

CREATE TABLE FACTURA(
	id_factura int NOT NULL IDENTITY(1,1),
	fecha	date	NOT NULL,
	id_usuario	int	NOT NULL,
	FOREIGN KEY(id_usuario) REFERENCES USUARIO(id_usuario),
	PRIMARY KEY(id_factura)
);

CREATE TABLE DETALLE_FACTURA(
	id_factura int	NOT NULL,
	id_paquete	int	NOT NULL,
	FOREIGN KEY(id_factura)	REFERENCES FACTURA(id_factura),
	FOREIGN KEY(id_paquete) REFERENCES PAQUETE(id_paquete),
	PRIMARY KEY(id_factura,id_paquete)
);