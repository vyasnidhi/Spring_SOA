/**
    Name : DisplayMostRecentAccountsController
    Author : Nidhi Vyas
    Date : 11 Nov, 2020
    Description : This apex class is used on DisplayMostRecentAccounts.
**/
public class DisplayMostRecentAccountsController {
    @AuraEnabled
    public static List<Account> getMostRecentlyCreatedAccount() {
        return [SELECT Id, Name, AccountNumber, Description, Industry, Phone, Website FROM Account ORDER BY Createddate DESC LIMIT 10];
    }
}