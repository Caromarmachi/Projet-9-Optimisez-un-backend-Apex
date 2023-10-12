public class UpdateAccountCAService {
    public void updateAccountCA(List<Order> listeOrder) {
        System.debug('Log CARO (classe AccountService) : dans methode updateAccountCA');

        Map<Id, String> accountMap = new Map<Id, String>();
        for (Order order : listeOrder)  {
            accountMap.put(order.AccountId, order.AccountId);
        }

        List<Account> updatedAccounts = new List<Account>();
        Map<Id, List<Order>> mapAccountOrder = new Map<Id, List<Order>>();

        // On recoupére toutes les commandes des comptes

        for (Order order : [SELECT Id, TotalAmount, AccountId, Status FROM Order WHERE AccountId = :accountMap.keySet()]) {
            if (mapAccountOrder.get(order.AccountId) != null) {
                mapAccountOrder.get(order.AccountId).add(order);
            } else {
                List<Order> listOrder = new List<Order>();
                listOrder.add(order);
                mapAccountOrder.put(order.AccountId, listOrder);
            }
        }

        for (Account account : [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accountMap.keySet()]) {
            decimal myAmount = 0;
            for (Order order : mapAccountOrder.get(account.Id)) {
                if (order.Status.equals('Ordered')) {
                    myAmount = myAmount + order.TotalAmount;
                }
            }
            System.debug('Log CARO (classe AccountService) : Montant CA calculé pour compte ' + account.Id + ' = ' + myAmount);
            account.Chiffre_d_affaire__c = myAmount;
            updatedAccounts.add(account);
        }

        update updatedAccounts;
        System.debug('Log CARO (classe AccountService) : fin methode updateAccountCA');
    }
}
