CREATE TABLE pedido (
  id int(11) NOT NULL auto_increment,
  nombre varchar(100) NOT NULL,
  telefono varchar(100) NOT NULL,
  direccion varchar(100) NOT NULL,
  comuna int(10) NOT NULL,
  tipp_masa int(10) NOT NULL,
  ingrediente int(10) NOT NULL,
  comentario TEXT(1000),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
