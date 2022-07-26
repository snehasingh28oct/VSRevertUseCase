public with sharing class CarParts {
   
        @AuraEnabled(cacheable=true)

        public static List<Car_Parts__c> getCarParts(){
    
            List<Car_Parts__c> carpart =[Select Name, Price__c,Car_Part_Number__c from Car_Parts__c];
    
            return carpart;
    
        }
    }