trigger ContactTrigger on Contact (before insert,before Update,before delete) {
    if(trigger.isBefore)
    {
        if(trigger.isInsert)
        {
            contactHandler1.BeforeInsert(Trigger.New);
        }
       else if(trigger.isUpdate)
        {
             contactHandler1.BeforeUpdate(Trigger.New);
        }
        else if(trigger.isDelete)
        {
            contactHandler1.BeforeDelete(Trigger.old);
        }
    }
    
  }