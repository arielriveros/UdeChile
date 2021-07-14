CREATE TABLE comentario_foto (
    id                   int8           auto_increment,
    fecha                datetime       not null,
    comentario           varchar(512)   not null,
    nota				 int(11)        not null,
    foto_bicho           int(11)        not null,
    primary key(id),
    foreign key(foto_bicho) references foto(id)
) 
ENGINE = INNODB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;
