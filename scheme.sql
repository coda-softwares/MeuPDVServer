-- MySQL Script generated by MySQL Workbench
-- Sáb 22 Abr 2017 16:17:33 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema MeuPDV
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `MeuPDV` ;

-- -----------------------------------------------------
-- Schema MeuPDV
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MeuPDV` DEFAULT CHARACTER SET utf8 ;
USE `MeuPDV` ;

-- -----------------------------------------------------
-- Table `MeuPDV`.`Contato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`Contato` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`Contato` (
  `id_Contato` INT NULL AUTO_INCREMENT,
  `tel_Contato` VARCHAR(45) NULL,
  `email_Contato` VARCHAR(45) NULL,
  `tel_alt_Contato` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Contato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`Fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`Fornecedor` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`Fornecedor` (
  `id_Forn` INT NULL AUTO_INCREMENT,
  `nome_Forn` VARCHAR(50) NOT NULL,
  `Contato_id_Contato` INT NULL,
  PRIMARY KEY (`id_Forn`),
  INDEX `fk_Fornecedor_Contato_idx` (`Contato_id_Contato` ASC),
  CONSTRAINT `fk_Fornecedor_Contato`
    FOREIGN KEY (`Contato_id_Contato`)
    REFERENCES `MeuPDV`.`Contato` (`id_Contato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`Produto` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`Produto` (
  `id_Prod` INT NULL AUTO_INCREMENT,
  `id_Forn` INT NOT NULL,
  `nome_Prod` VARCHAR(75) NOT NULL,
  `validade_Prod` DATE NOT NULL,
  `cdgBarras_Prod` BIGINT(19) NOT NULL,
  `val_Prod` DECIMAL(6,2) NOT NULL,
  `quant_Prod` INT NOT NULL,
  PRIMARY KEY (`id_Prod`),
  UNIQUE INDEX `cdgBarras_Prod_UNIQUE` (`cdgBarras_Prod` ASC),
  INDEX `fk_Produto_Fornecedor1_idx` (`id_Forn` ASC),
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`id_Forn`)
    REFERENCES `MeuPDV`.`Fornecedor` (`id_Forn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`Usuario` (
  `id_Usuario` INT NULL AUTO_INCREMENT,
  `nome_Usuario` VARCHAR(45) NOT NULL,
  `username_Usuario` VARCHAR(45) NOT NULL,
  `senha_Usuario` CHAR(64) NOT NULL,
  `salt_Usuario` CHAR(15) NOT NULL,
  `id_Contato` INT NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  INDEX `fk_Funcionario_Contato1_idx` (`id_Contato` ASC),
  UNIQUE INDEX `username_Usuario_UNIQUE` (`username_Usuario` ASC),
  CONSTRAINT `fk_Funcionario_Contato1`
    FOREIGN KEY (`id_Contato`)
    REFERENCES `MeuPDV`.`Contato` (`id_Contato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`Venda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`Venda` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`Venda` (
  `id_Venda` INT NULL AUTO_INCREMENT,
  `id_Funcionario` INT NOT NULL,
  `data_Venda` DATETIME NOT NULL DEFAULT NOW(),
  `valor_Venda` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_Venda`),
  INDEX `fk_Venda_Funcionario1_idx` (`id_Funcionario` ASC),
  CONSTRAINT `fk_Venda_Funcionario1`
    FOREIGN KEY (`id_Funcionario`)
    REFERENCES `MeuPDV`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`ListaProdutos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`ListaProdutos` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`ListaProdutos` (
  `id_ListaProdutos` INT NOT NULL,
  `ListaProdutoscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ListaProdutos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`Venda_Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`Venda_Produto` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`Venda_Produto` (
  `id_Venda` INT NULL AUTO_INCREMENT,
  `id_Prod` INT NULL,
  `unidades_Prod` INT NOT NULL,
  PRIMARY KEY (`id_Venda`, `id_Prod`),
  INDEX `fk_Venda_has_Produto_Produto1_idx` (`id_Prod` ASC),
  INDEX `fk_Venda_has_Produto_Venda1_idx` (`id_Venda` ASC),
  CONSTRAINT `fk_Venda_has_Produto_Venda1`
    FOREIGN KEY (`id_Venda`)
    REFERENCES `MeuPDV`.`Venda` (`id_Venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_has_Produto_Produto1`
    FOREIGN KEY (`id_Prod`)
    REFERENCES `MeuPDV`.`Produto` (`id_Prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`HistoricoLogin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`HistoricoLogin` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`HistoricoLogin` (
  `id_Login` INT NULL AUTO_INCREMENT,
  `data_Login` DATETIME NOT NULL DEFAULT NOW(),
  `macAddr_Login` CHAR(12) NOT NULL,
  `ip_Login` CHAR(17) NOT NULL,
  `id_Funcionario` INT NOT NULL,
  `token` VARCHAR(25) NULL,
  INDEX `fk_Logins_Funcionario1_idx` (`id_Funcionario` ASC),
  PRIMARY KEY (`id_Login`),
  CONSTRAINT `fk_Logins_Funcionario1`
    FOREIGN KEY (`id_Funcionario`)
    REFERENCES `MeuPDV`.`Usuario` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MeuPDV`.`Entrega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MeuPDV`.`Entrega` ;

CREATE TABLE IF NOT EXISTS `MeuPDV`.`Entrega` (
  `id_Entrega` INT NULL AUTO_INCREMENT,
  `id_Prod` INT NOT NULL,
  `data_Entrega` DATE NOT NULL,
  `quant_Entrega` INT NOT NULL,
  `custo_Entrega` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id_Entrega`),
  INDEX `fk_Entrega_Produto1_idx` (`id_Prod` ASC),
  CONSTRAINT `fk_Entrega_Produto1`
    FOREIGN KEY (`id_Prod`)
    REFERENCES `MeuPDV`.`Produto` (`id_Prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `MeuPDV` ;

-- -----------------------------------------------------
-- procedure Register
-- -----------------------------------------------------

USE `MeuPDV`;
DROP procedure IF EXISTS `MeuPDV`.`Register`;

DELIMITER $$
USE `MeuPDV`$$
CREATE PROCEDURE `Register` (pass varchar(50), username varchar(50), nome varchar(75)) 
BEGIN
	SET @salt = LEFT(UUID(), 8);
    SET @hashedPass = SHA2(CONCAT(@salt, pass),0);
    INSERT INTO Funcionario(nome_Funcionario, username_Funcionario, senha_Funcionario, salt_Funcionario) 
			VALUES (nome, username, @hashedPass, @salt);
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Login
-- -----------------------------------------------------

USE `MeuPDV`;
DROP procedure IF EXISTS `MeuPDV`.`Login`;

DELIMITER $$
USE `MeuPDV`$$
CREATE PROCEDURE `Login` ()
BEGIN
	SELECT nome_Usuario FROM Usuario
    WHERE username_Usuario=username AND senha_Usuario=SHA2(CONCAT(salt_Usuario, pass),0);
END$$

DELIMITER ;
USE `MeuPDV`;

DELIMITER $$

USE `MeuPDV`$$
DROP TRIGGER IF EXISTS `MeuPDV`.`Produto_BEFORE_INSERT` $$
USE `MeuPDV`$$
CREATE DEFINER = CURRENT_USER TRIGGER `MobPDV`.`Produto_BEFORE_INSERT` BEFORE INSERT ON `Produto` FOR EACH ROW
BEGIN
	SET @val = NEW.validade_Prod;
	IF @val >= CURDATE() THEN
		SET NEW.id_Prod = null;
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `MeuPDV`.`Contato`
-- -----------------------------------------------------
START TRANSACTION;
USE `MeuPDV`;
INSERT INTO `MeuPDV`.`Contato` (`id_Contato`, `tel_Contato`, `email_Contato`, `tel_alt_Contato`) VALUES (1, '11989773636', 'test@gmail.com', NULL);
INSERT INTO `MeuPDV`.`Contato` (`id_Contato`, `tel_Contato`, `email_Contato`, `tel_alt_Contato`) VALUES (2, '1121213534', 'tosozinhoemcasa@sqn.com', NULL);
INSERT INTO `MeuPDV`.`Contato` (`id_Contato`, `tel_Contato`, `email_Contato`, `tel_alt_Contato`) VALUES (3, '1198765422', 'nerdologia@sqn.com', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MeuPDV`.`Fornecedor`
-- -----------------------------------------------------
START TRANSACTION;
USE `MeuPDV`;
INSERT INTO `MeuPDV`.`Fornecedor` (`id_Forn`, `nome_Forn`, `Contato_id_Contato`) VALUES (1, 'Elmachips', NULL);
INSERT INTO `MeuPDV`.`Fornecedor` (`id_Forn`, `nome_Forn`, `Contato_id_Contato`) VALUES (2, 'Coca-Cola', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MeuPDV`.`Produto`
-- -----------------------------------------------------
START TRANSACTION;
USE `MeuPDV`;
INSERT INTO `MeuPDV`.`Produto` (`id_Prod`, `id_Forn`, `nome_Prod`, `validade_Prod`, `cdgBarras_Prod`, `val_Prod`, `quant_Prod`) VALUES (1, 1, 'Cheetos', '25/08/2017', 01234567800, 2.50, 300);
INSERT INTO `MeuPDV`.`Produto` (`id_Prod`, `id_Forn`, `nome_Prod`, `validade_Prod`, `cdgBarras_Prod`, `val_Prod`, `quant_Prod`) VALUES (2, 2, 'Coca-Cola', '02/02/2018', 01134567800, 5.00, 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `MeuPDV`.`Usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `MeuPDV`;
INSERT INTO `MeuPDV`.`Usuario` (`id_Usuario`, `nome_Usuario`, `username_Usuario`, `senha_Usuario`, `salt_Usuario`, `id_Contato`) VALUES (1, 'Samuel Henrique', 'samosaara', '1234', 'dsajdhash', 1);
INSERT INTO `MeuPDV`.`Usuario` (`id_Usuario`, `nome_Usuario`, `username_Usuario`, `senha_Usuario`, `salt_Usuario`, `id_Contato`) VALUES (2, 'Jefferson Bomfim', 'jeffbustercase', '4321', DEFAULT, 2);

COMMIT;

