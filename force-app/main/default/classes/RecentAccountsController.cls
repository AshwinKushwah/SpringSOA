public class RecentAccountsController {
	
    @AuraEnabled(cacheable= true)
    public static List<Account> getRecentAccounts(){
        return [Select Id, Name,No_of_Contacts__c, createdDate From Account order by createdDate LIMIT 10];
    }
}