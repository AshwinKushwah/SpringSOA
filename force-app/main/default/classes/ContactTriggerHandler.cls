public class ContactTriggerHandler {
	
    //Method to update the No of Contacts Field on Account
    //When Contact is inserted
    public static void updateNoOfContacts(List<Contact> contactList){
        List<Id> accountIds = new List<Id>();
        Map<Id, List<Contact>> accIdVsContactsMap = new Map<Id, List<Contact>>();
        for(Contact con : contactList){
            accountIds.add(con.AccountId);
            if(accIdVsContactsMap.containsKey(con.AccountId)){
                List<Contact> existingConList = accIdVsContactsMap.get(con.AccountId);
                existingConList.add(con);
            } else{
                List<Contact> newConList = new List<Contact>();
                accIdVsContactsMap.put(con.AccountId,newConList);
            }
            
        }
        List<Account> relatedAccounts = [Select Id, Name, No_of_Contacts__c From Account Where Id IN : accountIds];
        for(Account acc : relatedAccounts){
            if(accIdVsContactsMap.containsKey(acc.Id)){
                List<Contact> conList = accIdVsContactsMap.get(acc.Id);
                acc.No_of_Contacts__c = acc.No_of_Contacts__c + conList.size();
            }
        }
        
        if(relatedAccounts.size()>0){
            
            update relatedAccounts;
        }
    }
}