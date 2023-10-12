@isTest
public with sharing class SumAmountServiceTest {

    @isTest 
    static void test() {
        System.debug('Log CARO (SumAmountServiceTest) : lancement du test');
        Account account1 = new Account(Name = 'Test Account 1');
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
    //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 150,
            IsActive = true
        );
    // Créez l'Order en spécifiant le Pricebook
        Order o1 = new Order (
            AccountId = account1.Id, 
            EffectiveDate = Date.today(), 
            Status = 'Draft',
            ShipmentCost__c = 10,
            NetAmount__c = 140,
            Pricebook2Id = Test.getStandardPricebookId()
        );
     
        System.debug('Log CARO (SumAmountServiceTest) : 1 order  cree');

        List<Order> maListeOrder = new List<Order>();
        maListeOrder.add(o1);
       
        Test.startTest();
        SumAmountService monService = new SumAmountService();
        monService.calculateNetAmount(maListeOrder);

        Test.stopTest();

        System.debug('Log CARO (SumAmountServiceTest) : Verification du netAmmount pour le test');

    // Vérification des résultats
        System.assertEquals(140, o1.NetAmount__c, 'Net Ammount incorrect');
    }


}