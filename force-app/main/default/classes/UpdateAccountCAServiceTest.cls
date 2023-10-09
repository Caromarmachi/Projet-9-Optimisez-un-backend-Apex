@isTest
public with sharing class UpdateAccountCAServiceTest {

    @isTest 
    static void testOneOrder() {
        Test.startTest();

        System.debug('Log CARO (AccountServiceTest) : lancement du test');

        PopulateFakeOrderBook myFakeOrderBook = new PopulateFakeOrderBook();
        myFakeOrderBook.createBasicOrder();
        
      
        Test.stopTest();
        System.debug('Log CARO (TestUpdateAccounts) : fin d execution du batch');

        System.debug('Log CARO (TestUpdateAccounts) : Verification des CA pour le test');

    // Vérification des résultats
        Account accountVerif = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :myFakeOrderBook.getAccount().Id];
        System.assertEquals(150, AccountVerif.Chiffre_d_affaire__c, 'Chiffre d\'affaires incorrect');
    }

    @isTest 
    static void test200Order() {
        Test.startTest();

        System.debug('Log CARO (AccountServiceTest) : lancement du test 200 order');

        PopulateFakeOrderBook myFakeOrderBook = new PopulateFakeOrderBook();
        myFakeOrderBook.create200Order();
        
      
        Test.stopTest();
        System.debug('Log CARO (TestUpdateAccounts) : fin d execution du batch');

        System.debug('Log CARO (TestUpdateAccounts) : Verification des CA pour le test');

    // Vérification des résultats
        Account accountVerif = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :myFakeOrderBook.getAccount().Id];
        System.assertEquals(150*200, AccountVerif.Chiffre_d_affaire__c, 'Chiffre d\'affaires incorrect');
   
    
    }


}