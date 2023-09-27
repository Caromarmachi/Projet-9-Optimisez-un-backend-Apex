@isTest
private class TestMyTeamOrdersController {
    @isTest 
    static void test() {
               // Exécution de la classe de traitement par lots
        Test.startTest();
      
        MyTeamOrdersController monTeamOrderController = new MyTeamOrdersController();
        
        System.debug(monTeamOrderController.SumOders);  //valeur nulle....  comment appeller le controller?
        Double total = monTeamOrderController.SumOders.doubleValue(); // marche pas car null au dessus
        System.debug('Check CARO double value sum :' + total);

        Test.stopTest();

        // Vérification des résultats
        System.assertEquals(31500, total, 'total incorrect');
    }
}
