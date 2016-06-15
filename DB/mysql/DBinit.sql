-- MySQL Script generated by MySQL Workbench
-- Sun Jun 12 01:15:54 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema EdgoDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `EdgoDB` ;

-- -----------------------------------------------------
-- Schema EdgoDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EdgoDB` DEFAULT CHARACTER SET utf8 ;
USE `EdgoDB` ;

-- -----------------------------------------------------
-- Table `EdgoDB`.`Gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`Gene` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`Gene` (
  `ENTREZ_GENE_ID` INT NOT NULL,
  `OMIM_ID` INT NULL,
  `ENSEMBL_GENE_ID` VARCHAR(45) NULL,
  `UNIPROT_SWISSPROT_ID` VARCHAR(45) NULL,
  `CHROMOSOME_NAME` VARCHAR(45) NULL,
  `DESCRIPTION` VARCHAR(255) NULL,
  `HUGO_GENE_SYMBOL` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ENTREZ_GENE_ID`),
  UNIQUE INDEX `CCSB_ORF_ID_UNIQUE` (`HUGO_GENE_SYMBOL` ASC),
  UNIQUE INDEX `OMIM_ID_UNIQUE` (`OMIM_ID` ASC),
  UNIQUE INDEX `ENSEMBL_GENE_ID_UNIQUE` (`ENSEMBL_GENE_ID` ASC),
  UNIQUE INDEX `UNIPROT_SWISSPROT_ID_UNIQUE` (`UNIPROT_SWISSPROT_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`Transcript`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`Transcript` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`Transcript` (
  `REFSEQ_ID` VARCHAR(45) NOT NULL,
  `ENTREZ_GENE_ID` INT NOT NULL,
  PRIMARY KEY (`REFSEQ_ID`),
  INDEX `fk_Transcript_Gene1_idx` (`ENTREZ_GENE_ID` ASC),
  CONSTRAINT `fk_Transcript_Gene1`
    FOREIGN KEY (`ENTREZ_GENE_ID`)
    REFERENCES `EdgoDB`.`Gene` (`ENTREZ_GENE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`Variant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`Variant` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`Variant` (
  `VARIANT_ID` INT NOT NULL AUTO_INCREMENT COMMENT 'internal ID for the Variant table that auto increments',
  `CCSB_MUTATION_ID` INT NOT NULL COMMENT 'CCSB internal iD',
  `DBSNP_ID` VARCHAR(45) NULL COMMENT 'doesn’t have to be unique! ex. two rs10127939 to two different variant. NULL if #RS not available',
  `MUT_HGVS_NT_ID` VARCHAR(45) NOT NULL,
  `MUT_HGVS_AA_ID` VARCHAR(45) NOT NULL COMMENT 'doesn’t have to be unique due to codon degeneracy ex. NP_653200:p.G106R same for 2 different NM_ variant',
  `MUT_ORFEOME_NT` VARCHAR(45) NOT NULL,
  `MUT_ORFEOME_AA` VARCHAR(45) NOT NULL,
  `CHR_COORDINATE_HG18` VARCHAR(45) NOT NULL COMMENT 'empty string if data unavailable',
  `CHR_COORDINATE_HG19` VARCHAR(45) NULL COMMENT 'null if unconverted or data not available',
  `PMID` INT NULL COMMENT 'pubmed ID for the publication reporting the mutation. 0 if empty',
  `HGMD_ACCESSION` VARCHAR(45) NULL,
  `MUT_HGMD_AA` VARCHAR(45) NULL COMMENT 'mutation in protein sequence reported in HGMD',
  `HGMD_VARIANT_CLASS` VARCHAR(45) NULL COMMENT 'classification based on association with disease\n',
  `EXAC_ALLELE_FREQUENCY` DECIMAL(20,16) NULL COMMENT 'allele frequency extracted from exam browser',
  `REFSEQ_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`VARIANT_ID`),
  UNIQUE INDEX `CCSB_MUTATION_ID_UNIQUE` (`CCSB_MUTATION_ID` ASC),
  UNIQUE INDEX `HGVS_CDNA_ID_UNIQUE` (`MUT_HGVS_NT_ID` ASC),
  INDEX `fk_Variant_Transcript1_idx` (`REFSEQ_ID` ASC),
  UNIQUE INDEX `HGMD_ACCESSION_UNIQUE` (`HGMD_ACCESSION` ASC),
  CONSTRAINT `fk_Variant_Transcript1`
    FOREIGN KEY (`REFSEQ_ID`)
    REFERENCES `EdgoDB`.`Transcript` (`REFSEQ_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`LocalCollection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`LocalCollection` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`LocalCollection` (
  `LOCAL_COLLECTION_ID` INT NOT NULL AUTO_INCREMENT,
  `ENTRY_CLONE_PLATE` VARCHAR(45) NULL COMMENT 'mutant clone physical location in plate@well, entry clone\n',
  `ENTRY_CLONE_WELL` VARCHAR(45) NULL,
  `DESTINATION_CLONE_PLATE` VARCHAR(45) NULL COMMENT 'Mutant clone physical location in our collection (plate@well), 3xFLAG tagged expression vector',
  `DESTINATION_CLONE_WELL` VARCHAR(45) NULL,
  `FLAG_CHECK` VARCHAR(45) NULL COMMENT 'cloning of mutation allele from entry clone to 3xFLAG destination ok?',
  `VARIANT_ID` INT NOT NULL,
  PRIMARY KEY (`LOCAL_COLLECTION_ID`),
  INDEX `fk_LocalCollection_Variant1_idx` (`VARIANT_ID` ASC),
  UNIQUE INDEX `VARIANT_ID_UNIQUE` (`VARIANT_ID` ASC),
  CONSTRAINT `fk_LocalCollection_Variant1`
    FOREIGN KEY (`VARIANT_ID`)
    REFERENCES `EdgoDB`.`Variant` (`VARIANT_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`LUMIERMeasurementMUT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`LUMIERMeasurementMUT` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`LUMIERMeasurementMUT` (
  `VARIANT_ID` INT NOT NULL AUTO_INCREMENT,
  `INTERACTOR` VARCHAR(45) NOT NULL,
  `INTERACTION_Z_SCORE` DECIMAL(20,15) NULL COMMENT 'Interaction Z score of the mutant allele with interaction (a chaperone)',
  `INTERACTION_DIFFERENCE` DECIMAL(20,15) NULL COMMENT 'Difference in interaction Z scores between mutant and wild-type, both interacting with a chaperone',
  `INTERACTION_SIGNIFICANT` TINYINT(1) NULL COMMENT 'Significantly increased interaction with the interactor ( a chaperone ) from WT to mutant',
  `EXPRESSION_ELISA` DECIMAL(20,15) NULL COMMENT 'Expression level of the mutant allele with the interaction (a chaperone)',
  `EXPRESSION_RATIO` DECIMAL(20,15) NULL COMMENT 'Relative expression level (mutant/wild-type ratio) in interacting with the chaperone (the interaction)',
  PRIMARY KEY (`VARIANT_ID`, `INTERACTOR`),
  INDEX `fk_Measurement_Variant1_idx` (`VARIANT_ID` ASC),
  CONSTRAINT `fk_Measurement_Variant1`
    FOREIGN KEY (`VARIANT_ID`)
    REFERENCES `EdgoDB`.`Variant` (`VARIANT_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`LUMIERSummary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`LUMIERSummary` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`LUMIERSummary` (
  `VARIANT_ID` INT NOT NULL,
  `WT_ELISA_AVERAGE` DECIMAL(20,15) NULL COMMENT 'Average expression level across all experiments for the corresponding wild-type allele',
  `MUT_ELISA_AVERAGE` DECIMAL(20,15) NULL COMMENT 'Average expression level across all experiments for the mutant allele',
  `ELISA_RATIO_AVERAGE` DECIMAL(10,5) NULL COMMENT 'Relative expression level (mutant/wild-type ratio) across all experiments',
  `ELISA_LOG2_RATIO_AVERAGE` DECIMAL(10,5) NULL COMMENT 'Relative expression level (log2 ratio) across all experiments',
  `ELISA_LOG2_RATIO_SE` DECIMAL(10,5) NULL COMMENT 'Standard error of mean for relative expression level across all experiments\n\n',
  `ELISA_LOG2_RATIO_P_VALUE` DECIMAL(10,5) NULL COMMENT 'Significantly different expression level mutant vs wild-type?',
  PRIMARY KEY (`VARIANT_ID`),
  CONSTRAINT `fk_SummaryStatistics_Variant1`
    FOREIGN KEY (`VARIANT_ID`)
    REFERENCES `EdgoDB`.`Variant` (`VARIANT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`VariantProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`VariantProperty` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`VariantProperty` (
  `VARIANT_PROPERTY_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DISORDER_PROBABILITY` DECIMAL(3,2) NULL,
  `PFAM_PRESENT` TINYINT(1) NULL COMMENT 'protein contains a known  domain (annotated in pram)\n',
  `IN_PFAM` TINYINT(1) NULL COMMENT 'mutation in known pfam domain\n',
  `IN_MOTIF` TINYINT(1) NULL COMMENT 'mutation in known motif\n',
  `POLYPHEN_SCORE` DECIMAL(3,2) NULL,
  `POLYPHEN_CLASS` VARCHAR(45) NULL,
  `SOLVENT_ACCESSIBILITY` VARCHAR(45) NULL COMMENT 'solvent accessibility of mutated residue\n',
  `CONSERVATION_INDEX` DECIMAL(19,3) NULL COMMENT 'evolutionary conservation of mutated amino acid residue\n',
  `HYDROPHOBICITY_DECREASE` TINYINT(1) NULL COMMENT '1 mutation towards less hydrophobic residue, 0 mutation towards more hydrophobic residue\n',
  `PROTEIN_CHEMICAL_INTERFACE` VARCHAR(45) NULL COMMENT 'mutation in known protein chemical interface\n',
  `FOLDX_VALUE` DECIMAL(19,4) NULL COMMENT 'predicted effect of the mutation on protein thermodynamic stability',
  `CLINVAR_ID` INT NULL,
  `CLINVAR_CLINICAL_SIGNIFICANCE` VARCHAR(45) NULL,
  `VARIANT_ID` INT NOT NULL,
  PRIMARY KEY (`VARIANT_PROPERTY_ID`),
  INDEX `fk_StructuralEffect_Variant1_idx` (`VARIANT_ID` ASC),
  UNIQUE INDEX `VARIANT_ID_UNIQUE` (`VARIANT_ID` ASC),
  CONSTRAINT `fk_StructuralEffect_Variant1`
    FOREIGN KEY (`VARIANT_ID`)
    REFERENCES `EdgoDB`.`Variant` (`VARIANT_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`Disease`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`Disease` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`Disease` (
  `DISEASE_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DISEASE_NAME` VARCHAR(200) NOT NULL,
  `INHERITANCE_PATTERN` VARCHAR(200) NULL,
  `VARIANT_ID` INT NOT NULL,
  PRIMARY KEY (`DISEASE_ID`),
  INDEX `fk_Disease_Variant1_idx` (`VARIANT_ID` ASC),
  CONSTRAINT `fk_Disease_Variant1`
    FOREIGN KEY (`VARIANT_ID`)
    REFERENCES `EdgoDB`.`Variant` (`VARIANT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`ORFeome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`ORFeome` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`ORFeome` (
  `ORFEOME_ID` INT NOT NULL AUTO_INCREMENT,
  `CCSB_ORF_ID` INT NULL,
  `ORF_LENGTH` INT NULL,
  `CDS_ORFEOME_SEQ` VARCHAR(10000) NULL COMMENT 'ORFeome v.8.1 \n',
  `ENTREZ_GENE_ID` INT NOT NULL,
  INDEX `fk_OpenReadingFrame_Gene1_idx` (`ENTREZ_GENE_ID` ASC),
  PRIMARY KEY (`ORFEOME_ID`),
  UNIQUE INDEX `ENTREZ_GENE_ID_UNIQUE` (`ENTREZ_GENE_ID` ASC),
  CONSTRAINT `fk_OpenReadingFrame_Gene1`
    FOREIGN KEY (`ENTREZ_GENE_ID`)
    REFERENCES `EdgoDB`.`Gene` (`ENTREZ_GENE_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`HGMDMapping`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`HGMDMapping` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`HGMDMapping` (
  `HGMD_ACCESSION` VARCHAR(45) NOT NULL,
  `AA_CHANGE` VARCHAR(45) NOT NULL COMMENT 'mutation in protein sequence reported in HGMD',
  `VARIANT_CLASS` VARCHAR(10) BINARY NOT NULL COMMENT ' classification based on association with disease\n',
  `VARIANT_ID` INT NOT NULL,
  PRIMARY KEY (`HGMD_ACCESSION`),
  INDEX `fk_HGMDmapping_Variant1_idx` (`VARIANT_ID` ASC),
  UNIQUE INDEX `VARIANT_ID_UNIQUE` (`VARIANT_ID` ASC),
  CONSTRAINT `fk_HGMDmapping_Variant1`
    FOREIGN KEY (`VARIANT_ID`)
    REFERENCES `EdgoDB`.`Variant` (`VARIANT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`LUMIERMeasurementWT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`LUMIERMeasurementWT` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`LUMIERMeasurementWT` (
  `REFSEQ_ID` VARCHAR(45) NOT NULL,
  `INTERACTOR` VARCHAR(45) NOT NULL COMMENT 'a chaperone',
  `INTERACTION_Z_SCORE` DECIMAL(20,15) NULL COMMENT 'Interaction Z score of the wild type allele with interaction (a chaperone)',
  `EXPRESSION_ELISA` DECIMAL(20,15) NULL COMMENT 'Expression level of the corresponding wild-type allele interacting with a chaperone',
  INDEX `fk_LUMIERMeasurementsWT_Transcript1_idx` (`REFSEQ_ID` ASC),
  PRIMARY KEY (`REFSEQ_ID`, `INTERACTOR`),
  CONSTRAINT `fk_LUMIERMeasurementsWT_Transcript1`
    FOREIGN KEY (`REFSEQ_ID`)
    REFERENCES `EdgoDB`.`Transcript` (`REFSEQ_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`Y2HWTInteractor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`Y2HWTInteractor` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`Y2HWTInteractor` (
  `WT_INTERACTOR_ID` INT NOT NULL AUTO_INCREMENT,
  `INTERACTOR_ENTREZ_GENE_ID` INT NULL COMMENT 'enter gene id of the interactor of wild type allele',
  `Y2H_SCORE` TINYINT(1) NULL COMMENT '1 stands for interaction 0 stands for no interaction',
  `REFSEQ_ID` VARCHAR(45) NOT NULL COMMENT 'transcript ID of the wild type allele',
  INDEX `fk_Y2HMeasurementWT_Transcript1_idx` (`REFSEQ_ID` ASC),
  PRIMARY KEY (`WT_INTERACTOR_ID`),
  CONSTRAINT `fk_Y2HMeasurementWT_Transcript1`
    FOREIGN KEY (`REFSEQ_ID`)
    REFERENCES `EdgoDB`.`Transcript` (`REFSEQ_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EdgoDB`.`Y2HMUTInteractor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `EdgoDB`.`Y2HMUTInteractor` ;

CREATE TABLE IF NOT EXISTS `EdgoDB`.`Y2HMUTInteractor` (
  `MUT_INTERACTOR_ID` INT NOT NULL AUTO_INCREMENT,
  `INTERACTOR_ENTREZ_GENE_ID` INT NULL COMMENT 'enter gene id of the interactor of wild type allele',
  `Y2H_SCORE` TINYINT(1) NULL COMMENT '1 stands for interaction 0 stands for no interaction',
  `VARIANT_ID` INT NOT NULL,
  INDEX `fk_Y2HMUTInteractor_Variant1_idx` (`VARIANT_ID` ASC),
  PRIMARY KEY (`MUT_INTERACTOR_ID`),
  CONSTRAINT `fk_Y2HMUTInteractor_Variant1`
    FOREIGN KEY (`VARIANT_ID`)
    REFERENCES `EdgoDB`.`Variant` (`VARIANT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;