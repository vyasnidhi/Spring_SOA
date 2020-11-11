/**
    Name : ContactTriggerHelper
    Author : Nidhi Vyas
    Date : 11 Nov, 2020
    Description : This apex class is used as a helper class for contact trigger and it will populate the related account with total number number of contact that
                    are associated with that account.
**/
public class ContactTriggerHelper {

    public static void doAfterInsert(List<Contact> newList){
        Set<String> accountIds = new Set<String>();
        
        for(Contact con : newList) {
            if(con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
        
        if(!accountIds.isEmpty()) {
            countContactForRelatedAccount(accountIds);
        }
    }
    public static void doAfterUpdate(List<Contact> newList, Map<Id, Contact> newMap, List<Contact> oldList, Map<Id, Contact> oldMap){
        Set<String> accountIds = new Set<String>();
        
        for(Contact con : newList) {
            if(con.AccountId != oldMap.get(con.Id).AccountId) {
                if(con.AccountId != null) {
                    accountIds.add(con.AccountId);
                }
                if(oldMap.get(con.Id).AccountId != null) {
                    accountIds.add(oldMap.get(con.Id).AccountId);
                }
            }            
        }
        
        if(!accountIds.isEmpty()) {
            countContactForRelatedAccount(accountIds);
        }
    }
    
    public static void countContactForRelatedAccount(Set<String> accountIds) {
        List<Account> accountUpdateList = new List<Account>();
        
        for(AggregateResult ar : [SELECT Count(Id), AccountId FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            accountUpdateList.add(new Account(Id = String.valueOf(ar.get('AccountId')), Number_of_Contacts__c = Integer.valueOf(ar.get('expr0'))));
            accountIds.remove(String.valueOf(ar.get('AccountId')));
        }
        
        if(!accountIds.isEmpty()) {
            for(Id accId : accountIds) {
                accountUpdateList.add(new Account(Id = accId, Number_of_Contacts__c = null));
            }
        }
        
        if(!accountUpdateList.isEmpty()) {
            UPDATE accountUpdateList;
        }
    }
}