trigger CalculMontant on Order (before update) {
	
	for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
		//Order newOrder= trigger.new[0];
		newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
	}
}