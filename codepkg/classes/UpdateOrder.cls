global class UpdateOrder implements Database.Batchable<sObject> {
global database.QueryLocator start(Database.BatchableContext bc)
{
    return Database.getQueryLocator([Select Send_Order_Confirmation_Mail__c, Order_Placed__c from Cart__c]);
}
    global void execute(Database.BatchableContext bc,list<Cart__c> lList)
    {
        for(Cart__c l : lList)
        {
            if(l.Send_Order_Confirmation_Mail__c)
            l.Order_Placed__c = 'Yes';
        }
        update lList;
    }

        global void finish(Database.BatchableContext bc)
        {
            
        }
}