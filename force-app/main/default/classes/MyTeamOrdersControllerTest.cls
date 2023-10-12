@isTest
private class MyTeamOrdersControllerTest {
    @isTest 
    static void test() {
    // Exécution de la classe de traitement par lots
        Test.startTest();

        PopulateFakeOrderBook myFakeOrderBook = new PopulateFakeOrderBook();
        myFakeOrderBook.createBasicOrder();
        
      
        MyTeamOrdersController monTeamOrderController = new MyTeamOrdersController();
        Decimal total = monTeamOrderController.SumOrders;
        System.debug(monTeamOrderController.SumOrders);  
        System.debug('Check CARO double value sum :' + total);

        Test.stopTest();

    // Vérification des résultats
        System.assertEquals(150, total, 'total incorrect');
    }
}
