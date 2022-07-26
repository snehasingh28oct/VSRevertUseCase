trigger NewTry on Account (before insert) {
    List<Contact> result = new List<Contact>();
Set<Id> accIds = new Set<Id>();

    for(Account acc : trigger.new)
    {
        
            accIds.add(acc.Id);
        system.debug(accIds);
        
    }

    if(!accIds.isEmpty())
    {        
        for(Contact con : [Select ID,LastName, Account.Job_Name__c,Job__c FROM Contact where AccountID IN :accIds])
        {
            if(con.Account.Job_Name__c !=null){
               
                    con.Job__c = con.Account.Job_Name__c;
                    update con;
                }
             }
           
        }
}