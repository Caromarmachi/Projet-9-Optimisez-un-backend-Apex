@isTest
private class UpdateAccountsTest {
   
    @isTest 
    static void test() {
        System.debug('Log CARO (UpdateAccountsTest) : lancement du test');
        PopulateFakeOrderBook myFakeOrderBook = new PopulateFakeOrderBook();
        myFakeOrderBook.createBasicOrder();


    // Exécution de la classe de traitement par lots
        Test.startTest();
        System.debug('Log CARO (UpdateAccountsTest) : Lancement du batch');

        UpdateAccounts updateAccountsBatch = new UpdateAccounts();
        Database.executeBatch(updateAccountsBatch);
        Test.stopTest();
        System.debug('Log CARO (UpdateAccountsTest) : fin d execution du batch');

        System.debug('Log CARO (UpdateAccountsTest) : Verification des CA pour le test');

    // Vérification des résultats
        Account accountVerif = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :myFakeOrderBook.getAccount().Id];
        System.assertEquals(150, accountVerif.Chiffre_d_affaire__c, 'Chiffre d\'affaires incorrect');
    }
}
