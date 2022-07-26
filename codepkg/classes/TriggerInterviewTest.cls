@isTest
public class TriggerInterviewTest {
  static testMethod void interCandidate()
  {
      Test.startTest();
      Interviewer__c interviewer = new Interviewer__c();
      interviewer.Full_Name__c = 'Vismay Lall';
      interviewer.Age__c = 23;
      interviewer.Address__c = 'ABC Street';
      interviewer.Pin_Code__c = 1234;
      insert interviewer;
      
      Candidate__c candidate = new candidate__c();
      candidate.Associated_Interviewer__c = interviewer.Id;
      candidate.Full_Name__c = 'Sneha Singh';
      candidate.Position_Offered__c = 'GENC';
      insert candidate;
      
      try{
          delete interviewer;
      }
      catch(DMLException e){
          System.assert(e.getMessage().contains('Interviewer cannot be deleted'), 'Interviewer cannot be deleted');
      }
      Test.stopTest();
  }
}