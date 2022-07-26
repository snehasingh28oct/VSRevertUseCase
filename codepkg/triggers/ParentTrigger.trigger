trigger ParentTrigger on Parent__c (after update) {
    if(trigger.isAfter)
    {
        if(trigger.isUpdate)
        {
            Map<id,Parent__c> mapParent = new Map<id,Parent__c>();
            for(Parent__c p : trigger.new)
            {
                if(p.Status__c =='In-Progress')
                {
                mapParent.put(p.id,p);
                System.debug(mapParent);
                System.debug(mapParent.size());
                System.debug(mapParent.keySet());
                }
            }
            List<child__c> childList = new List<child__c>();
            List<Grand_Child__c> grandChildList = new List<Grand_Child__c>();
            childList = [Select id,subject__c,parent__c from child__c where parent__c in :mapParent.KeySet()];
            system.debug(childList); 
            Map<id,child__c> mapChild = new Map<id,child__c>();
            for(child__c cc:childList)
            {
                mapChild.put(cc.Id, cc);
            }
            grandChildList = [Select id,parent__c,subject__c from Grand_Child__c where parent__c in :mapChild.KeySet()];
            if(childList.size()>0)
            {
                for(child__c c : childList)
                {
                    c.Subject__c = mapParent.get(c.Parent__c).subject__c;
                }
            }
            if(grandChildList.size()>0)
            {
            for(Grand_Child__c g : grandChildList)
            {
                g.Subject__c = mapChild.get(g.Parent__c).subject__c;
            }
            }
            update childList;
            update grandChildList;
        }
    }

}