public class SumAmountService {
    public void calculateNetAmount(List<Order> newOrders) {
        System.debug('Log CARO (classe SumAmountService) : dans methode calculateNetAmount');

        for (Order newOrder : newOrders) {
            if (newOrder.ShipmentCost__c == null) {
                newOrder.ShipmentCost__c = 0;
            }
            if (newOrder.TotalAmount !=null)  {
                 newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
            }
           
        }

    }
}
