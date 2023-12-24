from django.db import models

class Customer(models.Model):
    SSN = models.CharField(max_length=11, primary_key=True)
    CusLastName = models.CharField(max_length=255)
    CusFirstName = models.CharField(max_length=255)
    CusMiddName = models.CharField(max_length=255, blank=True, null=True)
    CustSuffix = models.CharField(max_length=50, blank=True, null=True)
    CusDOB = models.DateField()
    CustSalutation = models.CharField(max_length=50, blank=True, null=True)
    CustEmailAddress = models.CharField(max_length=255, blank=True, null=True)
    Gender = models.BooleanField(null=True)
    CustomerLegacyID = models.IntegerField(null=True)
    WithholdingCode = models.IntegerField(null=True)
    StartDate = models.DateField(null=True)
    EndDate = models.DateField(null=True)
    CustomerAliasName = models.CharField(max_length=255, blank=True, null=True)
    CustomerAddressID = models.IntegerField(null=True)
    DocumentID = models.IntegerField(null=True)
    Age = models.IntegerField(null=True)
    Heredity = models.BooleanField(null=True)
    Income = models.IntegerField(null=True)
    InsufficientPhysicalExercises = models.BooleanField(null=True)
    SmokingAndDrinking = models.BooleanField(null=True)
    BurnTheMidnightOil = models.BooleanField(null=True)
    UnhealthyEatingHabit = models.BooleanField(null=True)
    UnstableEmotionStatus = models.BooleanField(null=True)
    TypicalChronicDiseases = models.CharField(max_length=255, blank=True, null=True)
    CustCountry = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.CusFirstName + ' ' + self.CusLastName

class CustomerAddress(models.Model):
    CustomerAddressID = models.AutoField(primary_key=True)
    SSN = models.ForeignKey(Customer, on_delete=models.CASCADE)
    CustAddress = models.CharField(max_length=255)
    CustCity = models.CharField(max_length=100)
    CustState = models.CharField(max_length=100)
    CustZip = models.CharField(max_length=20)
    AnnualStartDate = models.DateField(null=True)
    AnnualEndDate = models.DateField(null=True)

    def __str__(self):
        return self.CustAddress
