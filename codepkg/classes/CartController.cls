public class CartController {
    @AuraEnabled
    public static List <Cart__c> getAccounts() {
        return [SELECT Id, First_Name__c, Last_Name__c, Amount_Payable__c,Amount_Paid__c FROM Cart__c Where Confirm_Order__c=true ORDER BY createdDate ASC];
    }    
    @AuraEnabled
    public static List<Cart__c> findByName(String searchKey) {
        String name =  + searchKey + '%';
        return [SELECT id, First_Name__c, Last_Name__c, Amount_Payable__c,Amount_Paid__c FROM Cart__c WHERE Confirm_Order__c=true AND First_Name__c LIKE :name];
    }
}