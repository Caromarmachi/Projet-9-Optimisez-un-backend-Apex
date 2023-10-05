trigger CalculMontant on Order (before update) {
// commenter	
	for(integer i=0; i< trigger.new.size(); i++){
	
        Order newOrder= trigger.new[i];
		if (newOrder.ShipmentCost__c==null) {
			newOrder.ShipmentCost__c =0;
		}
		
		newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
	}
}
