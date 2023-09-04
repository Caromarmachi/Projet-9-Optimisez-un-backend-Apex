global class UpdateAccounts implements Database.Batchable<sObject>{ 
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator('SELECT Id FROM Account');
 
    }
     //amélioration du code
    global void execute(Database.BatchableContext info, List<Account> scope){   
        system.debug('dans classe updateAccount');
   
        list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];
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