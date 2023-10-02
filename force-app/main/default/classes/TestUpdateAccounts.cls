@isTest
private class TestUpdateAccounts {
   
    @isTest 
    static void test() {
        System.debug('Log CARO (TestUpdateAccounts) : lancement du test');

        Account Account1 = new Account(Name = 'Test Account 1');
        insert Account1;

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
            AccountId = Account1.Id, 
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
        
        System.debug('Log CARO (TestUpdateAccounts) : order et produits crees');


        System.debug('Log CARO (TestUpdateAccounts) : avant maj statut Ordered');

       o1.Status='Ordered';
       update o1;
       System.debug('Log CARO (TestUpdateAccounts) : apres maj statut Ordered');



        // Exécution de la classe de traitement par lots
        Test.startTest();
        System.debug('Log CARO (TestUpdateAccounts) : Lancement du batch');

        UpdateAccounts updateAccountsBatch = new UpdateAccounts();
        Database.executeBatch(updateAccountsBatch);
        Test.stopTest();
        System.debug('Log CARO (TestUpdateAccounts) : fin d execution du batch');

        System.debug('Log CARO (TestUpdateAccounts) : Verification des CA pour le test');

        // Vérification des résultats
        Account1 = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :Account1.Id];
        System.assertEquals(31500, Account1.Chiffre_d_affaire__c, 'Chiffre d\'affaires incorrect');
    }
}
