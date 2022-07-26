@isTest
public class ContactTriggerTest {
static testMethod void firstContactPrimary()
  {
      
      Account a = new Account();
      a.Name = 'Test Account';
      insert a;
      Contact c = new Contact();
      c.LastName = 'Singh';
      c.AccountId = a.id;
      try{
      insert c;
      }
      catch(DMLException e)
      {
          System.assert(e.getMessage().contains('The first contact has to primary'), 'The first contact has to be primary');
      }
  }
    static testMethod void uncheckingFirst()
    {
      Account a = new Account();
      a.Name = 'Test Account 1';
      insert a;
	
      Contact c1=new Contact();
      c1.LastName = 'Tejwani';
      c1.AccountId=a.id;
      c1.Primary_Contact__c=true;
      insert c1;
      
      Contact c2=new Contact();
      c2.LastName = 'Chandra';
      c2.AccountId = a.Id;
      c2.Primary_Contact__c = true;
      insert c2;
    }      
    static testMethod void onePrimaryContact()
    {
      Account a = new Account();
      a.Name = 'Test Account 2';
      insert a;
        
	  Contact c1=new Contact();
      c1.LastName = 'Tejwani';
      c1.AccountId=a.id;
      c1.Primary_Contact__c=true;
      insert c1;      
      
      Contact c3=new Contact();
      c3.LastName = 'Chandra';
      c3.AccountId = a.Id;
      c3.Primary_Contact__c = false;
      insert c3;
      
      c3.Primary_Contact__c=true;
        try{
             update c3;  
        }
        catch(DMLException e)
      {
          System.assert(e.getMessage().contains('You already have a primary contact. You cannot make a new one'), 'You already have a primary contact.You cannot make a new one');
      }
      
}
}