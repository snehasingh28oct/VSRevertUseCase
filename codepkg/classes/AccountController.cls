public class AccountController {
	@AuraEnabled
    public static Id creatingAccount (Account acct,Contact conn)
    {
        insert acct;
        conn.AccountId=acct.id;
        insert conn;
        return conn.Id;
        
    }    
}