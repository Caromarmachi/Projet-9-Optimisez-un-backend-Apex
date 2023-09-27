trigger CalculMontant on Order (before update) {
	System.debug('Log CARO (trigger CalculMontant) : lancement du trigger (before update)');


	for(integer i=0; i< trigger.new.size(); i++){
		// myAccount.Chiffre_d_affaire__c = 0;
        Order newOrder= trigger.new[i];
		if (newOrder.ShipmentCost__c==null) {
			newOrder.ShipmentCost__c =0;
		}
		//Order newOrder= trigger.new[0];
		newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
	}

	System.debug('Log CARO (trigger CalculMontant) : fin du trigger ');

}
