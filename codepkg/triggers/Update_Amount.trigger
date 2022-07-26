trigger Update_Amount on Item__c (before insert) {
if(trigger.isInsert && trigger.isBefore)
     for(Item__c i:trigger.new)
 {
 	
     i.Total_Amount__c =i.Amount__c;
 }
}