CREATE TABLE `Temas`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(255) NOT NULL,
    `Description` TEXT NULL
);
CREATE TABLE `Perfil_recursos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Recurso_id` BIGINT NOT NULL,
    `Variable_perfile_id` BIGINT NOT NULL,
    `Level` DECIMAL(8, 2) NOT NULL
);
CREATE TABLE `Marco_questions`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Marco_id` BIGINT NOT NULL,
    `Title` VARCHAR(255) NOT NULL,
    `Description` VARCHAR(255) NOT NULL,
    `Order` SMALLINT NOT NULL
);
CREATE TABLE `Docente_respuestas`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Docente_id` BIGINT NOT NULL,
    `Marco_question_id` BIGINT NOT NULL,
    `Marco_opcione_id` BIGINT NOT NULL,
    `Year` SMALLINT NOT NULL,
    `Trimester` TINYINT NOT NULL,
    `Created` DATETIME NOT NULL,
    `Updated` DATETIME NOT NULL
);
ALTER TABLE
    `Docente_respuestas` ADD UNIQUE `docente_respuestas_docente_id_unique`(`Docente_id`);
ALTER TABLE
    `Docente_respuestas` ADD UNIQUE `docente_respuestas_marco_question_id_unique`(`Marco_question_id`);
ALTER TABLE
    `Docente_respuestas` ADD UNIQUE `docente_respuestas_year_unique`(`Year`);
ALTER TABLE
    `Docente_respuestas` ADD UNIQUE `docente_respuestas_trimester_unique`(`Trimester`);
CREATE TABLE `Docentes`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(255) NOT NULL,
    `Last_name` VARCHAR(255) NOT NULL,
    `Birthdate` DATE NOT NULL
);
CREATE TABLE `Variable_perfiles`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Marco_id` BIGINT NULL COMMENT 'Null if not a tied to a performance',
    `Name` VARCHAR(255) NOT NULL,
    `Description` TEXT NOT NULL,
    `Order` BIGINT NOT NULL,
    `Is_for_training` BOOLEAN NOT NULL DEFAULT '1'
);
CREATE TABLE `Recurso_tipos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Title` VARCHAR(255) NOT NULL,
    `Description` TEXT NOT NULL
);
CREATE TABLE `Docente_recursos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Docente_id` BIGINT NOT NULL,
    `Recurso_id` BIGINT NOT NULL,
    `Compatibility` DECIMAL(4, 4) NOT NULL,
    `Started` BOOLEAN NOT NULL DEFAULT '0',
    `Finished` BOOLEAN NOT NULL DEFAULT '0'
);
CREATE TABLE `Marcos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Parent_id` BIGINT NOT NULL,
    `Title` VARCHAR(255) NOT NULL,
    `Description` TEXT NOT NULL,
    `Nest_level` TINYINT NOT NULL,
    `Order` TINYINT NOT NULL,
    `Is_performance` BOOLEAN NOT NULL,
    `Variable_perfile_id` BIGINT NULL
);
CREATE TABLE `Recursos`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Title` VARCHAR(255) NOT NULL,
    `Description` TEXT NULL,
    `Link` VARCHAR(255) NOT NULL,
    `Tema_id` BIGINT NULL,
    `Added_date` DATETIME NULL,
    `Recurso_tipo_id` BIGINT NOT NULL,
    `Metadata` JSON NULL
);
CREATE TABLE `Marco_opciones`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Marco_question_id` BIGINT NOT NULL,
    `Title` TEXT NOT NULL,
    `Value` DECIMAL(3, 2) NOT NULL,
    `Order` TINYINT NOT NULL
);
CREATE TABLE `Recurso_interaccion`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Recurso_id` BIGINT NOT NULL,
    `Docente_id` BIGINT NOT NULL,
    `Type` CHAR(4) NOT NULL,
    `Title` VARCHAR(255) NULL,
    `Body` TEXT NULL,
    `Value` SMALLINT NULL,
    `Created_at` DATETIME NOT NULL,
    `Deleted_at` DATETIME NULL
);
CREATE TABLE `Perfil_docentes`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Docente_id` BIGINT NOT NULL,
    `Variable_perfile_id` BIGINT NOT NULL,
    `Score` DECIMAL(8, 2) NOT NULL
);
ALTER TABLE
    `Perfil_docentes` ADD UNIQUE `perfil_docentes_docente_id_unique`(`Docente_id`);
ALTER TABLE
    `Perfil_docentes` ADD UNIQUE `perfil_docentes_variable_perfile_id_unique`(`Variable_perfile_id`);
CREATE TABLE `Usuarios`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Docente_id` BIGINT NOT NULL,
    `Type` BIGINT NOT NULL COMMENT '[R]egular, [A]dmin',
    `User` VARCHAR(255) NOT NULL,
    `Password` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `Usuarios` ADD UNIQUE `usuarios_user_unique`(`User`);
ALTER TABLE
    `Docente_recursos` ADD CONSTRAINT `docente_recursos_recurso_id_foreign` FOREIGN KEY(`Recurso_id`) REFERENCES `Recursos`(`id`);
ALTER TABLE
    `Docente_respuestas` ADD CONSTRAINT `docente_respuestas_marco_question_id_foreign` FOREIGN KEY(`Marco_question_id`) REFERENCES `Marco_questions`(`id`);
ALTER TABLE
    `Recursos` ADD CONSTRAINT `recursos_recurso_tipo_id_foreign` FOREIGN KEY(`Recurso_tipo_id`) REFERENCES `Recurso_tipos`(`id`);
ALTER TABLE
    `Perfil_docentes` ADD CONSTRAINT `perfil_docentes_variable_perfile_id_foreign` FOREIGN KEY(`Variable_perfile_id`) REFERENCES `Variable_perfiles`(`id`);
ALTER TABLE
    `Marco_questions` ADD CONSTRAINT `marco_questions_marco_id_foreign` FOREIGN KEY(`Marco_id`) REFERENCES `Marco_opciones`(`Marco_question_id`);
ALTER TABLE
    `Perfil_recursos` ADD CONSTRAINT `perfil_recursos_recurso_id_foreign` FOREIGN KEY(`Recurso_id`) REFERENCES `Recursos`(`id`);
ALTER TABLE
    `Docente_respuestas` ADD CONSTRAINT `docente_respuestas_marco_opcione_id_foreign` FOREIGN KEY(`Marco_opcione_id`) REFERENCES `Marco_opciones`(`id`);
ALTER TABLE
    `Docente_recursos` ADD CONSTRAINT `docente_recursos_docente_id_foreign` FOREIGN KEY(`Docente_id`) REFERENCES `Docentes`(`id`);
ALTER TABLE
    `Marco_questions` ADD CONSTRAINT `marco_questions_marco_id_foreign` FOREIGN KEY(`Marco_id`) REFERENCES `Marcos`(`id`);
ALTER TABLE
    `Marcos` ADD CONSTRAINT `marcos_variable_perfile_id_foreign` FOREIGN KEY(`Variable_perfile_id`) REFERENCES `Variable_perfiles`(`id`);
ALTER TABLE
    `Docente_respuestas` ADD CONSTRAINT `docente_respuestas_docente_id_foreign` FOREIGN KEY(`Docente_id`) REFERENCES `Docentes`(`id`);
ALTER TABLE
    `Recurso_interaccion` ADD CONSTRAINT `recurso_interaccion_recurso_id_foreign` FOREIGN KEY(`Recurso_id`) REFERENCES `Recursos`(`id`);
ALTER TABLE
    `Recurso_interaccion` ADD CONSTRAINT `recurso_interaccion_docente_id_foreign` FOREIGN KEY(`Docente_id`) REFERENCES `Docentes`(`id`);
ALTER TABLE
    `Recursos` ADD CONSTRAINT `recursos_tema_id_foreign` FOREIGN KEY(`Tema_id`) REFERENCES `Temas`(`id`);
ALTER TABLE
    `Perfil_recursos` ADD CONSTRAINT `perfil_recursos_variable_perfile_id_foreign` FOREIGN KEY(`Variable_perfile_id`) REFERENCES `Variable_perfiles`(`id`);
ALTER TABLE
    `Perfil_docentes` ADD CONSTRAINT `perfil_docentes_docente_id_foreign` FOREIGN KEY(`Docente_id`) REFERENCES `Docentes`(`id`);
ALTER TABLE
    `Marcos` ADD CONSTRAINT `marcos_parent_id_foreign` FOREIGN KEY(`Parent_id`) REFERENCES `Marcos`(`id`);
ALTER TABLE
    `Usuarios` ADD CONSTRAINT `usuarios_docente_id_foreign` FOREIGN KEY(`Docente_id`) REFERENCES `Docentes`(`id`);
ALTER TABLE
    `Variable_perfiles` ADD CONSTRAINT `variable_perfiles_marco_id_foreign` FOREIGN KEY(`Marco_id`) REFERENCES `Marcos`(`id`);