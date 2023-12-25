CREATE TABLE `CustomerImage` (
  `DocumentID` int,
  `ImageType` varchar(255), 
  `ImageFileLocation` varchar(255),  
  `DateReceived` date,
  PRIMARY KEY (`DocumentID`)
);

CREATE TABLE `Claim` (
  `ClaimNumber` int,
  `ClaimDate` date,
  `SettlementDate` date,
  `WellnessEligibilityDate` date,
  `ClaimImage` varchar(255),  
  `ContractNumber` int, 
  `LineOfBusiness` varchar(255),  
  `SSN` varchar(11),  
  PRIMARY KEY (`ClaimNumber`)
);

ALTER TABLE `Claim`
ADD INDEX (`SSN`);

ALTER TABLE `Claim`
ADD INDEX (`LineOfBusiness`);

ALTER TABLE `Claim`
ADD INDEX (`ContractNumber`);

CREATE TABLE `CustomerAlias` (
  `AliasFirstName` varchar(255),
  `AliasMiddleInitial` varchar(5),
  `AliasSuffix` varchar(50),
  `AliasDOB` date,
  `AliasSalutation` varchar(50),
  `AliasMailAddress` varchar(255),
  `AliasLastName` varchar(255)
);

ALTER TABLE `CustomerAlias`
ADD INDEX (`AliasMiddleInitial`);

ALTER TABLE `CustomerAlias`
ADD INDEX (`AliasFirstName`);

CREATE TABLE `Invoice` (
  `BAcctID` int,
  `CusSSN` varchar(11),
  `InvoceLineNumber` int,
  `PaidDate` date,
  `DueDate` date,
  `RunDate` date,
  `DetailID` int,
  `ConversionPendingFlag` tinyint,
  `PaidAheadFlag` tinyint
);

ALTER TABLE `Invoice`
ADD INDEX (`CusSSN`);

CREATE TABLE `CustomerAddress` (
  `CustAddress` varchar(255),
  `CustCity` varchar(100),
  `CustState` varchar(100),
  `CustZip` int,
  `AnnualStartDate` date,
  `AnnualEndDate` date
);

ALTER TABLE `CustomerAddress`
ADD INDEX (`CustAddress`);

CREATE TABLE `CompanyCode` (
  `CompanyName` varchar(255),
  `LegacyCompanyNo` int,
  PRIMARY KEY (`LegacyCompanyNo`) 
);

CREATE TABLE `AccMember` (
  `AccMemberName` varchar(255),
  `AccountID` int,
  `StartDate` date,
  `EndDate` date,
  `FSAContributionAmount` int,
  `CustBAcctDepartmentName` varchar(255),
  PRIMARY KEY (`AccountID`)
);

CREATE TABLE `FLEXAgreement` (
  `TransitOneFlag` bit
);

ALTER TABLE `FLEXAgreement`
ADD INDEX (`TransitOneFlag`);

CREATE TABLE `Account_Product` (
  `ProductLineOfBusiness` varchar(255),
  `AccountID` int,
  `StartDate` date,
  `EndDate` date,
  PRIMARY KEY (`AccountID`)
);

CREATE TABLE `Account` (
  `AccountName` varchar(255),
  `AccountID` int,
  `TaxIDNumber` int,
  `NumberOfEmployees` int,
  `NumberOfEmployeesDate` date,
  `ActivityStatus` bit,
  `GroupNumber` int,
  `LegacyFlexID` int,
  `AccountEstablishedDate` date,
  `PlanYearStartDate` date,
  `PlanYearEndDate` date,
  `SubsequentYearStartDate` date,
  `DualCompanyFlag` bit,
  `ComplexAccountFlag` bit,
  `StandardIndustryCode` int,
  `AnnualizedPremium` int,
  `NoOutstandingInvoices` int,
  `NoMonthsInactive` int,
  `LastInvoicePaidDate` date,
  `LastInvoicePaidDueDate` date,
  `LastInvoiceGenDate` date,
  `NextInvoiceGenDate` date,
  `LastServiceCallDate` date,
  `LastBillCount` int,
  `DisabilityOfferingStartDate` date,
  `AddressInformationSource` varchar(255),
  `WebAddress` varchar(255),
  `SpecialHandlingCode` int,
  `PEOFlag` bit,
  `DisabilityOfferingTaxStatus` bit,
  `TransitOneFlag` bit,
  `HSAFlag` bit,
  `HRAFlag` bit,
  `TotalPolicyCount` int,
  `PendingAnnualizedPremium` int,
  `PercentByLineOfBusiness` int,
  `ScheduledLapseDate` date,
  `PenetrationPercentage` int,
  `NoFSAParticipants` int,
  `AccountType` varchar(255),
  `LegacyCompanyNo` int,
  `TransittOneFlag` bit,
  `AccountLegacyAlias` varchar(255),
  `SSN` varchar(11),
  `BAcctID` int,
  PRIMARY KEY (`AccountID`),
  FOREIGN KEY (`LegacyCompanyNo`) REFERENCES `CompanyCode`(`LegacyCompanyNo`),
  FOREIGN KEY (`AccountID`) REFERENCES `AccMember`(`AccountID`),
  FOREIGN KEY (`TransitOneFlag`) REFERENCES `FLEXAgreement`(`TransitOneFlag`),
  FOREIGN KEY (`AccountID`) REFERENCES `Account_Product`(`AccountID`),
  KEY `Key` (`BAcctID`)
);

ALTER TABLE `Account`
ADD INDEX (`SSN`);

CREATE TABLE `Customers` (
  `SSN` varchar(11),
  `CusLastName` varchar(255),
  `CusFirstName` varchar(255),
  `CusMiddName` varchar(255),
  `CustSuffix` varchar(50),
  `CusDOB` date,
  `CustSalutation` varchar(50),
  `CustEmailAddress` varchar(255),
  `Gender` bit,
  `CustomerLegacyID` int,
  `WithholdingCode` int,
  `StartDate` date,
  `EndDate` date,
  `CustomerAliasName` varchar(255),
  `CustomerAddress` varchar(255),
  `DocumentID` int,
  `Age` int,
  `Heredity` bit,
  `Income` int,
  `InsufficientPhysicalExercises` bit,
  `SmokingAndDrinking` bit,
  `BurnTheMidnightOil` bit,
  `UnhealthyEatingHabit` bit,
  `UnstableEmotionStatus` bit,
  `TypicalChronicDiseases` varchar(255),
  `CustCountry` varchar(100),
  PRIMARY KEY (`SSN`),
  FOREIGN KEY (`DocumentID`) REFERENCES `CustomerImage`(`DocumentID`),
  FOREIGN KEY (`SSN`) REFERENCES `Claim`(`SSN`),
  FOREIGN KEY (`CustomerAliasName`) REFERENCES `CustomerAlias`(`AliasMiddleInitial`),
  FOREIGN KEY (`SSN`) REFERENCES `Invoice`(`CusSSN`),
  FOREIGN KEY (`CustomerAddress`) REFERENCES `CustomerAddress`(`CustAddress`),
  FOREIGN KEY (`SSN`) REFERENCES `Account`(`SSN`),
  FOREIGN KEY (`CustomerAliasName`) REFERENCES `CustomerAlias`(`AliasFirstName`)
);

CREATE TABLE `Payment` (
  `CreditCardNo` int,
  `ExpirationDate` date,
  `CardType` varchar(100),
  `BankingTransitNumber` int,
  `BankingAccountType` varchar(100),
  `PremiumPaymentLimit` int,
  `BankingAccountNumber` varchar(100),
  PRIMARY KEY (`CreditCardNo`)
);

CREATE TABLE `AHPolicy` (
  `ContractNumber` int
);

CREATE TABLE `District` (
  `DistrictName` varchar(100),
  `EndDate` date
);

ALTER TABLE `District`
ADD INDEX (`DistrictName`);

CREATE TABLE `CoordPositionProdChain` (
  `EndDate` date,
  `DistrictName` varchar(100),
  FOREIGN KEY (`DistrictName`) REFERENCES `District`(`DistrictName`)
);

CREATE TABLE `Territory` (
  `TerritoryName` varchar(100),
  `StartDate` date,
  `EndDate` date,
  PRIMARY KEY (`TerritoryName`)
);

CREATE TABLE `TerritoryCoordinator` (
  `TerritoryName` varchar(100),
  `EmployeeID` int,
  `EndDate` date
);

CREATE TABLE `Region` (
  `RegionName` varchar(100),
  `EndDate` date,
  `FieldDistrictName` varchar(100),
  FOREIGN KEY (`FieldDistrictName`) REFERENCES `District`(`DistrictName`)
);

ALTER TABLE `Region`
ADD INDEX (`RegionName`);

CREATE TABLE `AdminRole` (
  `RoleName` varchar(100),
  `AccountFlag` bit,
  `BAcctFlag` bit
);

ALTER TABLE `AdminRole`
ADD INDEX (`RoleName`);

CREATE TABLE `AccAdmin` (
  `AdminDescription` varchar(255),
  `AdminID` int,
  `AdminLastName` varchar(100),
  `AdminFirstName` varchar(100),
  `AdminMiddleInitial` varchar(5),
  `AdminSuffix` char(5),
  `AdminAddress` varchar(255),
  `AdminCity` varchar(100),
  `AdminState` varchar(100),
  `AdminZip` int,
  `Phone` bigint,
  `FaxNumber` bigint,
  `Gender` bit,
  `EmailAddress` varchar(255),
  `AdminRole` varchar(100),
  PRIMARY KEY (`AdminID`),
  FOREIGN KEY (`AdminRole`) REFERENCES `AdminRole`(`RoleName`)
);

CREATE TABLE `ContractPremium` (
  `AnnualizedPremium` int,
  `PremiumCode` int,
  `ProcessDate` date,
  `AppSignDate` date,
  `Premium_MgmtContract` varchar(255),
  PRIMARY KEY (`PremiumCode`)
);

CREATE TABLE `Contract` (
  `ContractNumber` int,
  `PremiumCode` int,
  `ActivityStatus` bit,
  `ActivityStatusDate` date,
  `CoverageType` varchar(255),
  `BillingMethod` varchar(255),
  `SuspendCode` int,
  `ExceptionCode` int,
  `ModalPremium` int,
  `AutoPremium` int,
  `CreditCardNo` int,
  `LanguageOfProduct` varchar(255),
  `AHPolicy` varchar(255),
  `ContractUnderwriting` varchar(255),
  `LifePolicy` varchar(255),
  `LineOfBusiness` varchar(255),
  `SeriesName` varchar(255),
  `PlanName` varchar(255),
  `SSN` varchar(11),
  PRIMARY KEY (`ContractNumber`),
  FOREIGN KEY (`CreditCardNo`) REFERENCES `Payment`(`CreditCardNo`),
  FOREIGN KEY (`ContractNumber`) REFERENCES `Claim`(`ContractNumber`),
  FOREIGN KEY (`PremiumCode`) REFERENCES `ContractPremium`(`PremiumCode`)
);

ALTER TABLE `Contract`
ADD INDEX (`LineOfBusiness`);

ALTER TABLE `Contract`
ADD INDEX (`SeriesName`);

ALTER TABLE `Contract`
ADD INDEX (`PlanName`);

CREATE TABLE `ClaimImage` (
  `DocumentID` int,
  `DocumentClass` varchar(255),
  `ImageType` varchar(255),
  `DateReceived` date,
  `ProcessedDate` date,
  PRIMARY KEY (`DocumentID`)
);

CREATE TABLE `StateOperationDivision` (
  `StateOperationDivisionName` varchar(255),
  `StateCode` int,
  `EndDate` date,
  `RegionName` varchar(255),
  FOREIGN KEY (`RegionName`) REFERENCES `Region`(`RegionName`)
);

ALTER TABLE `StateOperationDivision`
ADD INDEX (`StateOperationDivisionName`);

CREATE TABLE `StateOperation` (
  `StateOperationName` varchar(255),
  `TerritoryName` varchar(255),
  `StateOperationDivisionName` varchar(255),
  PRIMARY KEY (`StateOperationName`),
  FOREIGN KEY (`StateOperationDivisionName`) REFERENCES `StateOperationDivision`(`StateOperationDivisionName`),
  FOREIGN KEY (`TerritoryName`) REFERENCES `Territory`(`TerritoryName`)
);

CREATE TABLE `Account_Associate` (
  `CompanyCode` int,
  `Level` varchar(255),
  `StopDate` date,
  `ServiceType` varchar(255)
);

CREATE TABLE `Employee` (
  `EmployeeID` int,
  `EmpLastName` varchar(255),
  `EmpFirstName` varchar(255),
  `EmpMiddleInitial` varchar(5),
  `EmpAddress1` varchar(255),
  `EmpAddress2` varchar(255),
  `EmpCity` varchar(100),
  `EmpState` varchar(100),
  `EmpZip` int,
  PRIMARY KEY (`EmployeeID`)
);

CREATE TABLE `AccountLegacyAlias` (
  `AliasSource` varchar(255),
  `AliasID` int,
  `AliasName` varchar(255),
  `AliasAddress` text,
  `AliasCity` varchar(255),
  `AliasState` varchar(255),
  `AliasZip` int,
  `AliasPhone` bigint,
  `AliasEmailAddress` varchar(255),
  `AliasFax` varchar(255),
  PRIMARY KEY (`AliasID`)
);

CREATE TABLE `ContractUnderwriting` (
  `Underwriter` varchar(255),
  `DocumentID` int,
  `DateReceived` date,
  PRIMARY KEY (`DocumentID`)
);

CREATE TABLE `LifePolicy` (
  `InvestmentCode` int,
  `Principal` varchar(255),
  `InterestRate` int,
  `AccruedInterest` varchar(255),
  `BillingCode` int,
  `PaidToDate` date,
  `LastActivityDate` date,
  `LegalLastName` varchar(255),
  `LegalFirstName` varchar(255),
  `LegalMiddleInitial` varchar(5),
  `CashValue` int,
  `Mortality` int
);

CREATE TABLE `BillingAddress` (
  `AddressID` int,
  `BAcctID` int,
  `BillingAddress1` varchar(255),
  `BillingAddress2` varchar(255),
  `BillingCity` varchar(255),
  `BillingState` varchar(255),
  `BillingZip` int,
  PRIMARY KEY (`AddressID`)
) 
PARTITION BY HASH (AddressID)
PARTITIONS 4;

CREATE TABLE `Assoc_DBAs` (
  `DBA_TIN` varchar(255),
  `AssocPhone` bigint,
  `ConsolAssocID` int,
  `CorpEmailAddress` varchar(255),
  `AssocAddress1` varchar(255),
  `AssocAddress2` varchar(255),
  `AssocCity` varchar(255),
  `AssocState` varchar(255),
  `AssocZip` int,
  `DescriptionOfDBA` varchar(255),
  `StartDate` date,
  `NationalInsuranceID` int,
  PRIMARY KEY (`ConsolAssocID`)
);

CREATE TABLE `Associate` (
  `AssocLastName` varchar(255),
  `AssocFirstName` varchar(255),
  `AssocMiddleInitial` varchar(5),
  `AssocSuffix` char(5),
  `AssocDOB` date,
  `TenureDate` date,
  `WritingNumber` int,
  `Assoc_DBAs` varchar(255)
);

CREATE TABLE `Remittance` (
  `ClaimNumber` int,
  `ContractNumber` int,
  `RemittanceFreq` int,
  `RemittanceID` int,
  `RemittanceDate` date,
  `PaymentMethod` varchar(100)
);

CREATE TABLE `ManagerContract` (
  `SitCode` int,
  `IssueDate` date,
  `ContractType` varchar(100),
  `ContractSignDate` date,
  `ContractProcessDate` date,
  `CommissionCode` int,
  `EndDate` date,
  PRIMARY KEY (`SitCode`)
);

CREATE TABLE `Product` (
  `LineOfBusiness` varchar(100),
  `DescriptionPro` varchar(255),
  `SeriesName` varchar(100),
  `PlanName` varchar(100),
  `RatebookLocationCode` int,
  `AnnualizedPremium` int,
  `PSGName` varchar(100),
  PRIMARY KEY (`LineOfBusiness`),
  FOREIGN KEY (`LineOfBusiness`) REFERENCES `Contract`(`LineOfBusiness`),
  FOREIGN KEY (`DescriptionPro`) REFERENCES `Contract`(`SeriesName`),
  FOREIGN KEY (`LineOfBusiness`) REFERENCES `Claim`(`LineOfBusiness`),
  FOREIGN KEY (`SeriesName`) REFERENCES `Contract`(`PlanName`)
);

CREATE TABLE `Location` (
  `LocationID` varchar(100),
  `AccountID` varchar(100),
  `LocationAddress` varchar(255),
  `LocationCity` varchar(100),
  `LocationState` varchar(100), 
  `LocationZip` int,
  `LocationPhone` bigint,
  `MultiLocationAccountFlag` bit,
  PRIMARY KEY (`LocationID`)
);

CREATE TABLE `ContractManagerLink` (
  `ContractNumber` int,
  `SitCode` int
);

CREATE TABLE `BillingAccount` (
  `BAcctID` int,
  `BAcctName` varchar(255),
  `BAcctName2` varchar(255),
  `OnlineBillingFlag` bit,
  `ActivityStatus` bit,
  `ActivityStatusDate` date,
  `PayrollProcessorFlag` bit,
  `BillingPhone` bigint,
  `BillingAcctTypeDate` date,
  `SpecialHandlingCode` int,
  `ChangeFilesFlag` bit,
  `EnrollmentFileFlag` bit,
  `DebitCardFlag` bit,
  `BillingFileFlag` bit,
  `NextVisitDate` date,
  PRIMARY KEY (`BAcctID`),
  FOREIGN KEY (`BAcctID`) REFERENCES `Account`(`BAcctID`)
);

CREATE TABLE `Premium_MgmtContract` (
  `Amount` int,
  `CommissionRate` int
);

CREATE TABLE `TypicalChronicDiseases` (
  `CardiovascularDisease` tinyint,
  `Diabetes` tinyint,
  `Tumor` tinyint,
  `Hyperlipemia` tinyint,
  `Obesity` tinyint,
  `ChronicRespiratoryDisease` tinyint
);

CREATE TABLE `AccountEligiblity` (
  `AccountFlag` char,
  `BillingAccountFlag` char,
  `StartDate` date,
  `Description` varchar(255),
  `EndDate` date
);

CREATE TABLE `WritingNumber` (
  `writingNumber` int,
  `IssueDate` date,
  `StatusOfWriting` bit,
  `VestedFlag` bit,
  `TerminationDate` date,
  `ReinstatementDate` date,
  `NoPayRateNumerator` int,
  `NoPayRateDenominator` int,
  `PayAdvance` varchar(255),
  `PayAdvanceName` varchar(255),
  `Amount` int
);

CREATE INDEX idx_invoice_cusssn_duedate ON Invoice (CusSSN, DueDate);

CREATE INDEX idx_accountproduct_accountid_productline ON Account_Product (AccountID, ProductLineOfBusiness);

CREATE INDEX idx_account_accountid_taxid ON Account (AccountID, TaxIDNumber);

CREATE INDEX idx_customers_ssn_lastname ON Customers (SSN, CusLastName);

CREATE INDEX idx_customers_firstname_lastname_dob ON Customers (CusFirstName, CusLastName, CusDOB);

CREATE INDEX idx_payment_creditcardno_bankingaccount ON Payment (CreditCardNo, BankingAccountNumber);

CREATE INDEX idx_payment_cardtype_expirationdate ON Payment (CardType, ExpirationDate);

CREATE INDEX idx_contract_ssn_billingmethod ON Contract (SSN, BillingMethod);

CREATE INDEX idx_employee_lastname_firstname_state ON Employee (EmpLastName, EmpFirstName, EmpState);

CREATE INDEX idx_product_lineofbusiness_seriesname ON Product (LineOfBusiness, SeriesName);

CREATE INDEX idx_contractpremium_premiumcode_processdate ON ContractPremium (PremiumCode, ProcessDate);
