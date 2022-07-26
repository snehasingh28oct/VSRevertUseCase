trigger UpdateStatus on Cart__c (before insert,before update,before delete)
{
if(trigger.isInsert && trigger.isBefore)
{
for(Cart__c i:trigger.new){
if(i.Amount_Payable__c==0)
{
i.Status__c = 'Pending';
}
else if(i.Amount_Payable__c <= 5000 && i.Amount_Payable__c >0)
{
i.Status__c = 'Auto-Approved';
}

}
}
if(trigger.isUpdate && trigger.isBefore)
{
for(Cart__c i:trigger.new){
if(i.Amount_Payable__c <= 5000)
{
i.Status__c = 'Auto-Approved';
}
else{
i.Status__c='Pending';
}
}
}
if(trigger.isDelete && trigger.isBefore)
{
for(Cart__c i:trigger.new){
if(i.Amount_Payable__c <= 1000)
{
i.Status__c = 'Auto-Approved';
}
else{
i.Status__c='Pending';
}
}
}



}