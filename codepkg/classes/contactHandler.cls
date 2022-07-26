public class contactHandler {
    public static void BeforeInsert(List <contact> contactList)
    {         
        Map<id,List<Contact>> conMapTrue = new Map<Id,List<Contact>>();
        Map<id,List<Contact>> conMapFalse = new Map<id,List<Contact>>();
        List<Contact> conListTrue = new List<contact>();
        List<Contact> conListFalse = new List<contact>();
        List <contact> mapping = new List<contact>();
        if(contactList.size()>1)
        {
            for(Contact con:contactList)
            {
                if(con.Primary_Contact__c==true)
                {
                  
                        System.debug('HIIII');
						system.debug(con.AccountId);
						conListTrue.add(con);
						conMapTrue.put(con.AccountId,conListTrue);
						System.debug(conListTrue);
                    	System.debug(conListTrue.size());
                   		 System.debug(conMapTrue.size());
                    	System.debug(conMapTrue);
                    	conListTrue.clear();
                    }
                else 
                {
                    	System.debug('HIIII2');
						system.debug(con.AccountId);
						conListFalse.add(con);
						conMapTrue.put(con.AccountId,conListFalse);
						System.debug(conListFalse);
                    	System.debug(conListFalse.size());
                   		 System.debug(conMapFalse.size());
                    	System.debug(conMapFalse);
                    	conListFalse.clear();
                }
                    
                }
                
            }
        else{
     List<Id> accounts=new List<Id>();
    for(contact c:contactList)
    {
        if( c.AccountId!=Null)
            accounts.add(c.AccountId);
    }
    
    List<contact> contacts= [select id, phone from contact WHERE Primary_contact__c= true AND AccountId IN:accounts];
    for(contact c:contactList){
        if(c.Primary_contact__c==true){
            for(contact con: contacts)
            {
                con.Primary_contact__c=false;
            }
            
        }
        else if(contacts.size()==0 && c.Primary_Contact__c==false)
{
c.adderror('The First Contact needs to be primary');
}
    }
    update contacts;
}
    }
public static void BeforeUpdate(List<contact> contactList){
    List<Id> accounts=new List<Id>();
    for(contact c:contactList)
    {
        if( c.AccountId!=Null && c.Primary_Contact__c ==true)
            accounts.add(c.AccountId);
    }
    
    List<contact> contacts= [select id, phone from contact WHERE Primary_contact__c= true AND AccountId IN:accounts];
    if(contacts.size()>0)
    {
        for(contact c:contactList)
        {
            c.adderror('You already have a primary contact. You cannot update other contact as primary');
        }
    }
    
}
public static void BeforeDelete (List<Contact> contacts){
    for(Contact con:contacts){
        
        if(con.Primary_contact__c==true)
        {
            con.addError('Primary Contact Cannot be deleted');
        }
    }
    
}
}