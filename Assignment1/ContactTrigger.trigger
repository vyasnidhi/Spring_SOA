trigger ContactTrigger on Contact (After Insert, After Update, After delete, After Undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactTriggerHelper.doAfterInsert(trigger.new);
        }
        if(Trigger.isUpdate){
            ContactTriggerHelper.doAfterUpdate(trigger.new, trigger.newmap, trigger.old, trigger.oldmap);
        }
        if(Trigger.isDelete){
            ContactTriggerHelper.doAfterInsert(trigger.old);
        }
        if(Trigger.isUndelete){
            ContactTriggerHelper.doAfterInsert(trigger.new);
        }
    }
}