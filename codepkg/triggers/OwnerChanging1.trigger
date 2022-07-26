trigger OwnerChanging1 on Survey__c(before insert, before update) {
     List<String> userName = new List<String>();
    for(Survey__c opp : trigger.new)
{
	userName.add(opp.Candidates_Name__c);
}
map<string,id> userIdbyAlias = new map<string,id>();
for(User u : [Select id,Name from user where Name IN :userName])
{
userIdbyAlias.put(u.Name,u.Id);
}
for (Survey__c survey : Trigger.new)
{
if (survey.OwnerId <> userIdByAlias.get(survey.Candidates_Name__c) )
{
survey.OwnerId = userIdByAlias.get(survey.Candidates_Name__c);
}
}
}