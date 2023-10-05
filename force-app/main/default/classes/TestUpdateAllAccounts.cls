@isTest
private class TestUpdateAllAccounts {
    @isTest 
    static void test() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;   


    //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;

    // Créez l'Order en spécifiant le Pricebook
        Order o1 = new Order (
            AccountId = acc1.Id, 
            EffectiveDate = Date.today(), 
            Status = 'Draft',
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert o1;

        OrderItem oi1 = new OrderItem (
            OrderId = o1.Id, 
            PricebookEntryId = pbe.Id, 
            Quantity=10, 
            UnitPrice = 150
            );
        insert oi1;

        OrderItem oi2 = new OrderItem (
            OrderId = o1.Id, 
            PricebookEntryId = pbe.Id, 
            Quantity=30, 
            UnitPrice = 1000
            );
        insert oi2;  
       
        o1.Status='Ordered';
        update o1;

    // Exécution de la classe de traitement par lots
        Test.startTest();
        UpdateAllAccounts updateAllAccountsBatch = new UpdateAllAccounts();
        Database.executeBatch(updateAllAccountsBatch);
        Test.stopTest();

    // Vérification des résultats
        acc1 = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :acc1.Id];
        System.assertEquals(31500, acc1.Chiffre_d_affaire__c, 'Chiffre d\'affaires incorrect');
    }
}
