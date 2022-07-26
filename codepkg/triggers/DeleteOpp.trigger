trigger DeleteOpp on Opportunity(after update) {
 List<Id> lstId = new List<Id>();
 
for(Opportunity opp: Trigger.new){
        List<Opportunity> existoppList = [Select Id from Opportunity where Amount =: 2000000000];
        delete existoppList;
    }
 
}