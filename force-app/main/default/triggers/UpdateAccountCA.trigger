trigger UpdateAccountCA on Order ( after update, after delete) {
    System.debug('Log CARO (trigger UpdateAccountCA) : lancement du trigger (after update/delete)');


    Map<String, String> accountMap = new Map<String, String>(); //liste des IDs uniques de compte présents dans mon fichier

    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        accountMap.put(newOrder.AccountId, newOrder.AccountId);
    }

    System.debug('Log CARO (trigger UpdateAccountCA) : Nombre de compte ' + accountMap.size());


    List<Account> updatedAccount = new List<Account>();

    Map<Id, List<Order>> mapAccountOrder = new Map<Id, List<Order>>();

    // On recoupére toutes les commandes des comptes 
    for (Order order: [SELECT Id, TotalAmount, AccountId, Status FROM Order where AccountId=:accountMap.keySet()]) {
        if (mapAccountOrder.get(order.AccountId)!=null) {
            mapAccountOrder.get(order.AccountId).add(order);         
        } else {
            List<Order> listOrder = new List<Order>();
            listOrder.add(order);
            mapAccountOrder.put(order.AccountId, listOrder);
        }
    }
  
    for (Account account: [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:accountMap.keySet() ]) {
        decimal myAmount = 0;
   // si 101 comptes salesforce bloque la requette. map cles account id valeur liste d'order 
        for (Order order: mapAccountOrder.get(account.Id)) {
        
    // for (Order order: [SELECT Id, TotalAmount, AccountId, Status FROM Order where AccountId=:account.Id]) {      
            if (order.Status.equals('Ordered')) {
                myAmount = myAmount + order.TotalAmount;   
            }        
        }
        System.debug('Log CARO (trigger UpdateAccountCA) : Montant CA calculé pour compte ' + account.Id + ' = ' +  myAmount);

        account.Chiffre_d_affaire__c = myAmount;
        updatedAccount.add(account);
    }

    update updatedAccount;
    System.debug('Log CARO (trigger UpdateAccountCA) : fin du trigger ');

}