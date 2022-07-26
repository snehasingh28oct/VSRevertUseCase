trigger TriggerInterviewer on Interviewer__c (before delete) {  
    Set<id> interId = new Set<id>();
    for(Interviewer__c i : Trigger.old)  
    {  
        interId.add(i.id);  
    }  
    Map<Id,Interviewer__c> interview = new Map<Id, Interviewer__c>([Select Id, (Select Id from Candidates__r) from Interviewer__c where id in :interId]);
	for(Interviewer__c i : Trigger.old)
    {
        if(interview.get(i.id).Candidates__r.size()>0)
        {
            i.adderror('You cannot delete the Interviewer as the interviewer have pending Candidate');
            }
        }     
}