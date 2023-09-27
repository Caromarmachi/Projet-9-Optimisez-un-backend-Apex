public without sharing class MyTeamOrdersController {  //la classe
    public decimal SumOders{  // la methode, sans parametre ni parenthese?
       get{   //methode dans methode? comment l'appeller dans ma classe de test?
       AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order where Order.Tec_Actuel_User__c = true];
			return (decimal)groupedResults.get('total');

        }
        set;  // autre methode dans methode.... comment l'appeller?
    }
}