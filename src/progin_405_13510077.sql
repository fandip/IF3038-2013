SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `accounts`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `accounts` (
  `idaccounts` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(30) NULL ,
  `password` VARCHAR(255) NULL ,
  `email` VARCHAR(30) NULL ,
  `nama_lengkap` VARCHAR(30) NULL ,
  `tgl_lahir` DATE NULL ,
  `avatar` VARCHAR(255) NULL ,
  PRIMARY KEY (`idaccounts`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kategori`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `kategori` (
  `idkategori` INT NOT NULL AUTO_INCREMENT ,
  `nama` VARCHAR(30) NULL ,
  `pembuat` INT NOT NULL ,
  PRIMARY KEY (`idkategori`) ,
  INDEX `fk_kategori_accounts1` (`pembuat` ASC) ,
  CONSTRAINT `fk_kategori_accounts1`
    FOREIGN KEY (`pembuat` )
    REFERENCES `accounts` (`idaccounts` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tugas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tugas` (
  `idtugas` INT NOT NULL AUTO_INCREMENT ,
  `nama` VARCHAR(45) NULL ,
  `deadline` DATE NULL ,
  `status_selesai` TINYINT(1) NULL ,
  `kategori_idkategori` INT NOT NULL ,
  PRIMARY KEY (`idtugas`) ,
  INDEX `fk_tugas_kategori1` (`kategori_idkategori` ASC) ,
  CONSTRAINT `fk_tugas_kategori1`
    FOREIGN KEY (`kategori_idkategori` )
    REFERENCES `kategori` (`idkategori` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `komentar`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `komentar` (
  `idkomentar` INT NOT NULL AUTO_INCREMENT ,
  `isi` VARCHAR(511) NULL ,
  `tugas_idtugas` INT NOT NULL ,
  `accounts_idaccounts` INT NOT NULL ,
  `CREATED` DATETIME NULL ,
  PRIMARY KEY (`idkomentar`) ,
  INDEX `fk_komentar_tugas1` (`tugas_idtugas` ASC) ,
  INDEX `fk_komentar_accounts1` (`accounts_idaccounts` ASC) ,
  CONSTRAINT `fk_komentar_tugas1`
    FOREIGN KEY (`tugas_idtugas` )
    REFERENCES `tugas` (`idtugas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_komentar_accounts1`
    FOREIGN KEY (`accounts_idaccounts` )
    REFERENCES `accounts` (`idaccounts` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tag`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tag` (
  `idtag` INT NOT NULL AUTO_INCREMENT ,
  `nama` VARCHAR(30) NULL ,
  PRIMARY KEY (`idtag`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tugas_has_tag`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tugas_has_tag` (
  `tugas_idtugas` INT NOT NULL ,
  `tag_idtag` INT NOT NULL ,
  INDEX `fk_tugas_has_tag_tag1` (`tag_idtag` ASC) ,
  INDEX `fk_tugas_has_tag_tugas1` (`tugas_idtugas` ASC) ,
  CONSTRAINT `fk_tugas_has_tag_tugas1`
    FOREIGN KEY (`tugas_idtugas` )
    REFERENCES `tugas` (`idtugas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tugas_has_tag_tag1`
    FOREIGN KEY (`tag_idtag` )
    REFERENCES `tag` (`idtag` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `accounts_has_tugas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `accounts_has_tugas` (
  `accounts_idaccounts` INT NOT NULL ,
  `tugas_idtugas` INT NOT NULL ,
  `pembuat` TINYINT(1) NULL ,
  INDEX `fk_accounts_has_tugas_tugas1` (`tugas_idtugas` ASC) ,
  INDEX `fk_accounts_has_tugas_accounts1` (`accounts_idaccounts` ASC) ,
  CONSTRAINT `fk_accounts_has_tugas_accounts1`
    FOREIGN KEY (`accounts_idaccounts` )
    REFERENCES `accounts` (`idaccounts` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_has_tugas_tugas1`
    FOREIGN KEY (`tugas_idtugas` )
    REFERENCES `tugas` (`idtugas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignee_has_kategori`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `assignee_has_kategori` (
  `accounts_idaccounts` INT NOT NULL ,
  `kategori_idkategori` INT NOT NULL ,
  INDEX `fk_accounts_has_kategori_kategori1` (`kategori_idkategori` ASC) ,
  INDEX `fk_accounts_has_kategori_accounts1` (`accounts_idaccounts` ASC) ,
  CONSTRAINT `fk_accounts_has_kategori_accounts1`
    FOREIGN KEY (`accounts_idaccounts` )
    REFERENCES `accounts` (`idaccounts` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accounts_has_kategori_kategori1`
    FOREIGN KEY (`kategori_idkategori` )
    REFERENCES `kategori` (`idkategori` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attachment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `attachment` (
  `idtable1` INT NOT NULL AUTO_INCREMENT ,
  `path` VARCHAR(45) NULL ,
  `nama` VARCHAR(255) NULL ,
  `tugas_idtugas` INT NOT NULL ,
  PRIMARY KEY (`idtable1`) ,
  INDEX `fk_attachment_tugas1` (`tugas_idtugas` ASC) ,
  CONSTRAINT `fk_attachment_tugas1`
    FOREIGN KEY (`tugas_idtugas` )
    REFERENCES `tugas` (`idtugas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
