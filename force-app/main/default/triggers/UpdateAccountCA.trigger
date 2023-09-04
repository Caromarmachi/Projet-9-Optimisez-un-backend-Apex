trigger UpdateAccountCA on Order ( after update, after delete) {
	System.debug('Check CARO');

    Map<String, Order> accountMap = new Map<String, Order>();

    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        accountMap.put(newOrder.AccountId, newOrder);
    }

    System.debug('Nombre de compte ' + accountMap.size());

    Map<String, decimal> majCAMap = new Map<String, Decimal>();

    for (String key : accountMap.keySet()){
        decimal myAmount = 0;
        for (Order order: [SELECT Id, TotalAmount, AccountId, Status FROM Order where AccountId=:key]) {      
            if (order.Status.equals('Ordered')) {
                myAmount = myAmount + order.TotalAmount;   
            }        
        }
        majCAMap.put(key, myAmount);
        System.debug('Montant CA calculé pour compte ' + key + ' = ' +  myAmount);

    }


    List<Account> updatedAccount = new List<Account>();
    for (Account account: [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:accountMap.keySet() ]) {
        account.Chiffre_d_affaire__c = majCAMap.get(account.Id);
        updatedAccount.add(account);
    }
    update updatedAccount;

         

}