global with sharing class UpdateAllAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       return Database.getQueryLocator('SELECT Id FROM Account');

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){
  
   Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
   //AP01Account.updateChiffreAffaire(setAccountIds);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}