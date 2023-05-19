public class CheckboxListController {
	
     @AuraEnabled(cacheable=true)
     public static List <String> getPiklistValues() {
        List<String> plValues = new List<String>();
         
        //Get the object type from object name. Here I've used custom object Book.
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Account');
         
        //Describe the sObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
         
        //Get the specific field information from field name. Here I've used custom field Genre__c of Book object.
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('Domains__c').getDescribe();
         
        //Get the picklist field values.
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
         
        //Add the picklist values to list.
        for(Schema.PicklistEntry plv: picklistvalues) {
            plValues.add(plv.getValue());
        }
        plValues.sort();
        return plValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<String> selectedCheckbox(String recordId){
        List<Account> acc = [Select Id, Domains__c from Account Where Id = :recordId];
        String res = acc[0].Domains__c;
        List<String> lis = new List<String>();
        lis = res.split(';');
        return lis;
      //  List<String> res = new List<String>();
       // for(String s : acc[0].Domains__c){
        //    res.add(s);
       // }
        //return res;
    }
    
    @AuraEnabled
    public static String saveRecord(String recordId, String values){
          List<Account> acc = [select Id, Domains__c from Account where Id = :recordId];
          acc[0].Domains__c = values;
          update acc;
          return 'Test';
        
    }
}