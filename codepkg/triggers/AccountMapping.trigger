trigger AccountMapping on Account (after insert, after update) {
    List<Lead> LeadList = new List<Lead>();
    List<Mapping__mdt> metaList = [Select Source_Object__c,Source_Object_Field__c, Destination_Object__c,Destination_Object_Field__c from Mapping__mdt];
    system.debug(metaList);
    Map<String, String> FieldMapping = new Map<String, String>();
        for(Mapping__mdt mapObj : metaList)
{
    FieldMapping.put(mapObj.Destination_Object_Field__c, mapObj.Source_Object_Field__c);
    System.debug(FieldMapping);
    System.debug(FieldMapping.keySet());
}
     for(Account acc : trigger.new)
    {
    Lead LeadObj = new Lead();
    for(String LeadField : FieldMapping.keyset())
    { 
        LeadObj.put(LeadField ,acc.get(FieldMapping.get(LeadField)));
    }
        LeadObj.LastName = acc.Name;
        LeadObj.Company = acc.Name;
        LeadList.add(LeadObj);
        
        }
    insert LeadList;
}