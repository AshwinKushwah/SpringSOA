public class LWCSaveEditRow {
    
	  @AuraEnabled(Cacheable = true)
    public static List<Account> getAccounts() {

        List<Account> accList = [SELECT Id, Name, Phone, Industry, Type, Website, Description FROM Account WHERE Phone != null AND Industry != null ORDER BY CreatedDate DESC  LIMIT 20];

        return accList;
    }
}