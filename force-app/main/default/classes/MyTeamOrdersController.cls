public with sharing class MyTeamOrdersController {  
    public decimal SumOrders {
        get {
            String status = 'Ordered';
            AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Order.Tec_Actuel_User__c = true AND Order.Status=:status];
            if (groupedResults.get('total') != null) {
                return (decimal)groupedResults.get('total');
            } else {
                return 0; 
            }
        }
    }
}