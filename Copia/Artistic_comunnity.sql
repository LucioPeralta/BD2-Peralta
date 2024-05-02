#DROP DATABASE IF EXISTS Artistic_Community;
CREATE DATABASE IF NOT EXISTS Artistic_Community;

USE Artistic_Community;

CREATE TABLE IF NOT EXISTS Usuario (
    id_usuario INT,
    nombre VARCHAR(255),
    correo VARCHAR(255),
    contrasena VARCHAR(255),
    CONSTRAINT PK_Usuario PRIMARY KEY (id_usuario)
);

CREATE TABLE IF NOT EXISTS PerfilArtista (
    id_perfil INT,
    informacion_personal VARCHAR(255),
    habilidades VARCHAR(255),
    experiencia VARCHAR(255),
    portfolio VARCHAR(255),
    enlaces_trabajo VARCHAR(255),
    likes INT,
    id_usuario INT,
    CONSTRAINT PK_PerfilArtista PRIMARY KEY (id_perfil),
    CONSTRAINT FK_PerfilArtista_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS Proyecto (
    id_proyecto INT,
    nombre VARCHAR(255),
    estado VARCHAR(255),
    descripcion TEXT,
    categoria VARCHAR(255),
    CONSTRAINT PK_Proyecto PRIMARY KEY (id_proyecto)
);

CREATE TABLE IF NOT EXISTS Evento (
    id_evento INT,
    nombre VARCHAR(255),
    descripcion TEXT,
    ubicacion VARCHAR(255),
    capacidad_max INT,
    entradas_vendidas INT,
    precio_unitario INT,
    fecha DATE,
    hora TIME,
    id_usuario INT,
    CONSTRAINT PK_Evento PRIMARY KEY (id_evento),
    CONSTRAINT FK_Evento_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS Servicio (
    id_servicio INT,
    nombre VARCHAR(255),
    descripcion TEXT,
    precio INT,
    id_usuario INT,
    CONSTRAINT PK_Servicio PRIMARY KEY (id_servicio),
    CONSTRAINT FK_Servicio_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS Donacion (
    id_donacion INT,
    monto INT,
    id_usuario INT,
    CONSTRAINT PK_Donacion PRIMARY KEY (id_donacion),
    CONSTRAINT FK_Donacion_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS Publicacion (
    id_publicacion INT,
    fecha DATE,
    descripcion TEXT,
    id_usuario INT,
    CONSTRAINT PK_Publicacion PRIMARY KEY (id_publicacion),
    CONSTRAINT FK_Publicacion_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS ComentarioPublicacion (
    id_comentarioPublicacion INT,
    descripcion TEXT,
    likes INT,
    id_publicacion INT,
    CONSTRAINT PK_ComentarioPublicacion PRIMARY KEY (id_comentarioPublicacion),
    CONSTRAINT FK_Comentario_Publicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);

CREATE TABLE IF NOT EXISTS ComentarioPerfil (
    id_comentarioPerfil INT,
    descripcion TEXT,
    likes INT,
    id_perfil INT,
    CONSTRAINT PK_ComentarioPerfil PRIMARY KEY (id_comentarioPerfil),
    CONSTRAINT FK_ComentarioPerfil_Perfil FOREIGN KEY (id_perfil) REFERENCES PerfilArtista(id_perfil)
);

CREATE TABLE IF NOT EXISTS MensajePrivado (
    id_mensajePriv INT,
    texto VARCHAR(255),
    fecha DATE,
    CONSTRAINT PK_MensajePrivado PRIMARY KEY (id_mensajePriv)
);

CREATE TABLE IF NOT EXISTS DetalleProyecto (
    id_detalle_proyecto INT,
    id_proyecto INT,
    id_usuario INT,
    CONSTRAINT PK_DetalleProyecto PRIMARY KEY (id_detalle_proyecto),
    CONSTRAINT FK_DetalleProyecto_Proyecto FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto),
    CONSTRAINT FK_DetalleProyecto_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE IF NOT EXISTS DetalleMsjPriv (
    id_detalle_msjPriv INT,
    texto VARCHAR(255),
    id_usuario_crea INT,
    id_usuario_recep INT,
    id_mensajePriv INT,
    CONSTRAINT PK_DetalleMsjPriv PRIMARY KEY (id_detalle_msjPriv),
    CONSTRAINT FK_DetalleMsjPriv_UsuarioCrea FOREIGN KEY (id_usuario_crea) REFERENCES Usuario(id_usuario),
    CONSTRAINT FK_DetalleMsjPriv_UsuarioRecep FOREIGN KEY (id_usuario_recep) REFERENCES Usuario(id_usuario),
    CONSTRAINT FK_DetalleMsjPriv_MensajePrivado FOREIGN KEY (id_mensajePriv) REFERENCES MensajePrivado(id_mensajePriv)
);

CREATE TABLE IF NOT EXISTS Grupo (
    id_grupo INT,
    nombre VARCHAR(255),
    CONSTRAINT PK_Grupo PRIMARY KEY (id_grupo)
);

CREATE TABLE IF NOT EXISTS DetalleGrupo (
    id_detalleGrupo INT,
    id_usuario_crea INT,
    descripcion TEXT,
    id_grupo INT,
    id_usuario INT,
    CONSTRAINT PK_DetalleGrupo PRIMARY KEY (id_detalleGrupo),
    CONSTRAINT FK_DetalleGrupo_UsuarioCrea FOREIGN KEY (id_usuario_crea) REFERENCES Usuario(id_usuario),
    CONSTRAINT FK_DetalleGrupo_Grupo FOREIGN KEY (id_grupo) REFERENCES Grupo(id_grupo),
    CONSTRAINT FK_DetalleGrupo_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- INSERTS para la tabla Usuario
INSERT INTO Usuario (id_usuario, nombre, correo, contrasena) VALUES 
(1, 'Juan', 'juan@example.com', 'contrasena123'),
(2, 'Maria', 'maria@example.com', 'clave456'),
(3, 'Pedro', 'pedro@example.com', 'p@ssw0rd'),
(4, 'Ana', 'ana@example.com', 'securepass'),
(5, 'Luis', 'luis@example.com', 'qwerty');

-- INSERTS para la tabla PerfilArtista
INSERT INTO PerfilArtista (id_perfil, informacion_personal, habilidades, experiencia, portfolio, enlaces_trabajo, likes, id_usuario) VALUES 
(1, 'Artista visual especializado en pintura al óleo.', 'Pintura al óleo, retratos, paisajes', '10 años de experiencia como pintor', 'www.portfolio.com/pintor1', 'www.instagram.com/pintor1', 150, 1),
(2, 'Escultor contemporáneo con enfoque en materiales reciclados.', 'Escultura, reciclaje, arte urbano', 'Exposiciones en galerías locales e internacionales', 'www.portfolio.com/escultor2', 'www.facebook.com/escultor2', 200, 2),
(3, 'Fotógrafo artístico especializado en retratos.', 'Fotografía, retratos, blanco y negro', 'Trabajo publicado en revistas de arte reconocidas', 'www.portfolio.com/fotografo3', 'www.flickr.com/fotografo3', 300, 3),
(4, 'Muralista con experiencia en arte callejero.', 'Murales, arte callejero, graffiti', 'Participación en festivales de arte urbano', 'www.portfolio.com/muralista4', 'www.twitter.com/muralista4', 250, 4),
(5, 'Ilustrador digital especializado en fantasía y ciencia ficción.', 'Ilustración digital, fantasía, ciencia ficción', 'Diseño de portadas para libros y juegos', 'www.portfolio.com/ilustrador5', 'www.artstation.com/ilustrador5', 180, 5);

-- INSERTS para la tabla Proyecto
INSERT INTO Proyecto (id_proyecto, nombre, estado, descripcion, categoria) VALUES 
(1, 'Estatua de la libertad', 'En curso', 'Escultura de gran escala en bronce', 'Escultura'),
(2, 'Mural comunitario', 'Finalizado', 'Mural colaborativo en el centro de la ciudad', 'Arte urbano'),
(3, 'Exposición fotográfica', 'En curso', 'Colección de retratos en blanco y negro', 'Fotografía'),
(4, 'Instalación interactiva', 'En curso', 'Instalación de arte digital con sensores de movimiento', 'Arte digital'),
(5, 'Colección de pinturas', 'En curso', 'Serie de paisajes al óleo inspirados en la naturaleza', 'Pintura');

-- INSERTS para la tabla Evento
INSERT INTO Evento (id_evento, nombre, descripcion, ubicacion, capacidad_max, entradas_vendidas, precio_unitario, fecha, hora, id_usuario) VALUES 
(1, 'Concierto en el parque', 'Concierto al aire libre con bandas locales', 'Parque central', 500, 450, 10, '2022-04-15', '18:00:00', 2),
(2, 'Exposición de arte contemporáneo', 'Muestra de obras de artistas locales', 'Galería de arte XYZ', 200, 180, 5, '2024-03-30', '10:00:00', 1),
(3, 'Taller de fotografía', 'Clases prácticas de fotografía digital', 'Estudio Fotográfico ABC', 20, 15, 25, '2024-04-05', '15:00:00', 3),
(4, 'Presentación de libro ilustrado', 'Lanzamiento de libro con ilustraciones de fantasía', 'Librería Fantástica', 50, 40, 15, '2024-04-10', '19:00:00', 5),
(5, 'Recital de poesía', 'Recital de poesía contemporánea', 'Café Literario', 100, 90, 8, '2024-04-20', '20:00:00', 4);

-- INSERTS para la tabla Servicio
INSERT INTO Servicio (id_servicio, nombre, descripcion, precio, id_usuario) VALUES 
(1, 'Retrato personalizado', 'Retrato al óleo sobre lienzo', 100, 1),
(2, 'Sesión fotográfica profesional', 'Sesión de retratos en estudio', 50, 3),
(3, 'Diseño de logotipos', 'Creación de logotipos personalizados', 80, 5),
(4, 'Mural personalizado', 'Mural artístico en pared interior o exterior', 200, 4),
(5, 'Clases de pintura', 'Clases grupales de pintura al óleo', 30, 2);

-- INSERTS para la tabla Donacion
INSERT INTO Donacion (id_donacion, monto, id_usuario) VALUES 
(1, 50, 2),
(2, 20, 4),
(3, 100, 1),
(4, 30, 3),
(5, 10, 5);

-- INSERTS para la tabla Publicacion
INSERT INTO Publicacion (id_publicacion, fecha, descripcion, id_usuario) VALUES 
(1, '2024-03-20', '¡Nuevo mural en la calle principal!', 4),
(2, '2024-03-22', 'Exposición de fotografía este sábado.', 3),
(3, '2024-03-25', 'Retrato al óleo de paisaje natural.', 1),
(4, '2024-03-28', '¡Próximo concierto en el parque!', 2),
(5, '2024-03-30', 'Iniciando nuevo proyecto de escultura.', 5),
(6, '2024-03-15', '¡Nuevo mural en el centro de la ciudad!', 4),
(7, '2024-03-18', 'Compartiendo mi última obra de arte.', 1),
(8, '2024-03-20', 'Recién terminé esta escultura. ¿Qué opinan?', 5),
(9, '2024-03-22', 'Fotografía de la puesta de sol.', 3),
(10, '2024-03-25', '¡Próximo evento de arte en la galería!', 2),
(11, '2024-03-28', 'Iniciando un nuevo proyecto de pintura.', 1),
(12, '2024-03-30', 'Ilustración digital inspirada en la naturaleza.', 5),
(13, '2024-04-02', 'Compartiendo mi último trabajo fotográfico.', 3),
(14, '2024-04-05', '¡Nuevo mural en la avenida principal!', 4),
(15, '2024-04-10', 'Paisaje al óleo de montañas.', 1);

-- INSERTS para la tabla Comentario
INSERT INTO ComentarioPublicacion (id_comentarioPublicacion, descripcion, likes, id_publicacion) VALUES 
(1, '¡Excelente trabajo!', 15, 1),
(2, '¿Quién es el artista?', 8, 2),
(3, 'Me encanta esta pintura, tiene colores cálidos.', 12, 3),
(4, '¿Habrá más conciertos?', 45, 2),
(5, '¡Qué hermoso trabajo! Me encanta tu estilo.', 20, 3),
(6, '¿Dónde puedo adquirir una de tus obras?', 10, 4);

INSERT INTO ComentarioPerfil (id_comentarioPerfil, descripcion, likes, id_perfil) VALUES
(1, 'Gran perfil!', 50, 1),
(2, 'Me encanta tu trabajo', 30, 1),
(3, 'Muy inspirador', 20, 2),
(4, 'Excelente contenido', 45, 2),
(5, 'Fascinante', 25, 3),
(6, '¡Sigue así!', 15, 3),
(7, 'Increíble trabajo', 40, 4),
(8, 'Genial!', 10, 4),
(9, 'Maravilloso', 35, 5),
(10, 'Impresionante', 28, 5);

-- INSERTS para la tabla MensajePrivado
INSERT INTO MensajePrivado (id_mensajePriv, texto, fecha) VALUES 
(1, 'Hola, ¿cómo estás?', '2024-03-15'),
(2, '¿Quieres colaborar en un proyecto?', '2024-03-18'),
(3, '¡Felicidades por tu exposición!', '2024-03-25'),
(4, '¿Podrías enviarme más información?', '2024-03-28'),
(5, '¿Cuándo será el próximo taller?', '2024-04-02');

-- INSERTS para la tabla DetalleProyecto
INSERT INTO DetalleProyecto (id_detalle_proyecto, id_proyecto, id_usuario) VALUES 
(1, 1, 2),
(2, 2, 4),
(3, 3, 3),
(4, 4, 5),
(5, 5, 1);

-- INSERTS para la tabla DetalleMsjPriv
INSERT INTO DetalleMsjPriv (id_detalle_msjPriv, texto, id_usuario_crea, id_usuario_recep, id_mensajePriv) VALUES 
(1, 'Hola, ¿cómo estás?', 1, 2, 1),
(2, 'Sí, claro. ¿De qué se trata?', 2, 1, 2),
(3, '¡Gracias! Fue un éxito.', 3, 4, 3),
(4, 'Por supuesto, te enviaré los detalles.', 4, 3, 4),
(5, 'El taller será el próximo sábado.', 5, 3, 5);

-- INSERTS para la tabla Grupo
INSERT INTO Grupo (id_grupo, nombre) VALUES 
(1, 'Artistas Urbanos'),
(2, 'Fotógrafos de Naturaleza'),
(3, 'Ilustradores Fantásticos'),
(4, 'Escultores Contemporáneos'),
(5, 'Pintores Locales');

-- INSERTS para la tabla DetalleGrupo
INSERT INTO DetalleGrupo (id_detalleGrupo, id_usuario_crea, descripcion, id_grupo, id_usuario) VALUES 
(1, 1, 'Grupo para artistas callejeros.', 1, 2),
(2, 2, 'Comunidad de amantes de la naturaleza.', 2, 3),
(3, 3, 'Para ilustradores de fantasía y ciencia ficción.', 3, 5),
(4, 4, 'Espacio para escultores experimentales.', 4, 4),
(5, 5, 'Encuentro para pintores aficionados.', 5, 1);

#1
SELECT u.id_usuario, u.nombre AS 'Nombre', COUNT(*) AS 'Num_publicaciones'
FROM Usuario u
INNER JOIN Publicacion p ON u.id_usuario = p.id_usuario
INNER JOIN DetalleGrupo dg ON p.id_usuario = dg.id_usuario
GROUP BY u.id_usuario
HAVING MAX(p.fecha) >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY Num_publicaciones desc
LIMIT 10;

#2
SELECT  cp.id_comentarioPerfil, cp.descripcion, cp.likes, cp.id_perfil
FROM ComentarioPerfil cp
INNER JOIN PerfilArtista pa ON(cp.id_perfil = pa.id_perfil)
INNER JOIN Usuario u ON(u.id_usuario = pa.id_usuario)
WHERE u.nombre LIKE '%[^a-zA-Z0-9]%'
ORDER BY cp.likes DESC
LIMIT 30;

#3
SELECT e.nombre, e.entradas_vendidas, e.precio_unitario ,SUM(e.entradas_vendidas * precio_unitario) AS 'Monto recaudado'
FROM Evento e 
GROUP BY e.nombre, e.entradas_vendidas, e.precio_unitario;

#4
SELECT p.*, COUNT(c.id_comentarioPublicacion) AS num_comments
FROM Publicacion p 
INNER JOIN ComentarioPublicacion c ON p.id_publicacion = c.id_publicacion 
WHERE c.descripcion LIKE '%colores cálidos%' 
GROUP BY p.id_publicacion 
HAVING COUNT(c.id_comentarioPublicacion) > 10 
LIMIT 0, 1000;


#5
SELECT p.*
FROM Proyecto p
INNER JOIN DetalleProyecto dp ON(p.id_proyecto = dp.id_proyecto)
WHERE p.categoria = '%Escultura'
AND p.estado = '%En curso'
GROUP BY p.id_proyecto
HAVING COUNT(dp.id_usuario) >= 10;