@isTest
private class TestMyTeamOrdersController {
    @isTest 
    static void test() {
    // Exécution de la classe de traitement par lots
        Test.startTest();
      
        MyTeamOrdersController monTeamOrderController = new MyTeamOrdersController();
        Decimal total = monTeamOrderController.SumOrders;
        System.debug(monTeamOrderController.SumOrders);  
        Double totalDouble = total.doubleValue(); 
        System.debug('Check CARO double value sum :' + total);

        Test.stopTest();

        // Vérification des résultats
        System.assertEquals(0, total, 'total incorrect');
    }
}
