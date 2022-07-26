public class contactHandler1
{
    public static void BeforeInsert(List <contact> contactList)
    {
         List<Id> accountsid=new List<Id>();
    for(contact c:contactList)
    {
        if( c.AccountId!=Null)
            accountsid.add(c.AccountId);
    }
        Map<id,List<Contact>> conMapTrue = new Map<Id,List<Contact>>();
        List<contact> conList = new List<contact>();
        Map<id,contact> conMapOld = new Map<Id,contact>();
        for(Contact connn : [SELECT Id, Primary_Contact__c,AccountId FROM Contact
						WHERE Primary_Contact__c=true AND AccountId in : accountsid]){
						conMapOld.put(connn.AccountId,connn);
						}

        if(contactList.size()>1)
        {
        for(Id acc:accountsid)
                    {
                        conMapTrue.put(acc,new contact[0]);
                        System.debug(conMapTrue);
                        System.debug(conMapTrue.size());
                    }
     		for(Contact con:contactList)
            {
                if(con.Primary_Contact__c==true)
                {
                        conMapTrue.get(con.AccountId).add(con);
                        System.debug(conMapTrue);
                        System.debug(conMapTrue.size());
                    }
            }
            for(Contact con : contactList)
            {
                System.debug(conMapTrue.get(con.AccountId).size());
                if(conMapTrue.get(con.AccountId).size()>1)
                {
				  con.adderror('You cannot insert more than one primary contact');           
                }
                //New Approach with Map
                else if(conMapTrue.get(con.AccountId).size()==1)
                {
                    if(con.AccountId!=null && con.Primary_Contact__c==true )
                    {
                        conMapOld.get(con.AccountId).Primary_Contact__c = false;
						conList.add(conMapOld.get(con.AccountId));
                    }
                }
                else if(conMapTrue.get(con.AccountId).size()==0 & conMapOld.containsKey(con.AccountId)== false)
                {
                    con.adderror('It is Mandatory to have one primary contact.');
                }
          }
            if(conList.size()>0)
            {
			update conList;
			}
    /*List<Id> accounts=new List<Id>();
    for(contact c:contactList)
    {
        if( c.AccountId!=Null)
            accounts.add(c.AccountId);
    }
    List<contact> contacts= [select id, phone from contact WHERE Primary_contact__c= true AND AccountId IN:accountsid];
    for(contact c:contactList)
    {
        if(c.Primary_contact__c==true)
        {
            for(contact con: contacts)
            {
                con.Primary_contact__c=false;
            }
        }
    }
    update contacts;*/
		}
        else{
       /* List<Id> accounts=new List<Id>();
    for(contact c:contactList)
    {
        if( c.AccountId!=Null)
            accounts.add(c.AccountId);
    }*/
    List<contact> contacts= [select id, phone from contact WHERE Primary_contact__c= true AND AccountId IN:accountsid];
    for(contact c:contactList){
        if(c.Primary_contact__c==true){
            for(contact con: contacts)
            {
                con.Primary_contact__c=false;
            }
            
        }
        /*else if(contacts.size()==0 && c.Primary_Contact__c==false)
				{
			c.adderror('The First Contact needs to be primary');
				}*/
    }
    update contacts;
    }
    }
    public static void BeforeUpdate(List<contact> contactList)
    {
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
public static void BeforeDelete (List<Contact> contacts)
{
    for(Contact con:contacts)
    {
        if(con.Primary_contact__c==true)
        {
            con.addError('Primary Contact Cannot be deleted');
        }
    }
}
}