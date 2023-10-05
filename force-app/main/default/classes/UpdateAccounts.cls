global  with sharing class UpdateAccounts implements Database.Batchable<sObject>{ 
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        
    //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        String monStatus = 'Ordered';
        return Database.getQueryLocator('SELECT Account.Id FROM Account WHERE Account.Id IN (SELECT Order.AccountId from ORDER WHERE Order.Status=:monStatus)' );
    }
    //classe qui est destinée à être utilisée comme un job batch dans Salesforce
    global void execute(Database.BatchableContext info, List<Account> scope){   
        String status = 'Ordered';

        list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE Order.Status=:status];
         for (Account myAccount : scope) {
             myAccount.Chiffre_d_affaire__c = 0; 
             for(Order myOrder : listOrders){
                 if(myOrder.AccountId == myAccount.Id){
                     myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + myOrder.TotalAmount; 
                 }                   
             }
         }
      
        update scope;
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }
 
