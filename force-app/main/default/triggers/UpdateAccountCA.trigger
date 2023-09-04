trigger UpdateAccountCA on Order ( after update, after delete) {
	System.debug('Check CARO');

    Map<String, Order> accountMap = new Map<String, Order>();

    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        accountMap.put(newOrder.AccountId, newOrder);
    }

    System.debug('Nombre de compte ' + accountMap.size());


    for (String key : accountMap.keySet()){
        System.debug(key);
        list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId, Status FROM Order where AccountId=:key];
        system.debug('size listorders for this account ' + listOrders.size());

        decimal myAmount = 0;
        for(Order myOrder : listOrders){
            if (myOrder.Status.equals('Ordered')) {
                    myAmount = myAmount + myOrder.TotalAmount;    
            }          
        }
        system.debug('my Amount total for this account ' + myAmount);

        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:key ];
        acc.Chiffre_d_affaire__c = myAmount;
        update acc;
        System.debug('Compte ' + key + ' mis à jour.');
    }
    
 

   


     

}