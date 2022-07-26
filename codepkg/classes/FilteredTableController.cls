public with sharing class FilteredTableController {
    @AuraEnabled(cacheable=true)
    public static List<Job__c> getCases(
        String Name
    ) {
        String query;
        String condition = (String.isNotBlank(Name)
            ? 'Name LIKE \'' + '%' + Name + '%\''
            : '');

        

        

        System.debug('condition ' + condition);
        if (String.isNotBlank(condition)) {
            query =
                'SELECT Name FROM Job__c WHERE ' +
                condition ;
        } else {
            query = 'SELECT Name FROM Job__c LIMIT 200';
        }

        List<Job__c> records = Database.query(query);
        return records;
    }
}