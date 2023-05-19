public class TCT_ComboBoxController {

    @AuraEnabled
    public static List<String> getSearchList(List<String> pickListValues, String value) {
        //Initiate the list that is going to be returned
        List<String> searchResultList = new List<String>();
        String lowerCaseValue=value.toLowerCase();
        try {
            //for every item of the list check if what user has typed is contained in the List of Citizenships
            for (Integer i=0; i<pickListValues.size(); i++) {
                String val=pickListValues[i].toLowerCase();
                if (val.contains(lowerCaseValue)) {
                    searchResultList.add(pickListValues[i]);
                }
            }
        } catch (Exception e) {
            system.debug('exception caught: ' +e.getMessage());
        }
        return searchResultList;
    }
    
    
     @AuraEnabled
    // Method to get Picklist values
    public static List<String> getPickListValuesCus(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            pickListValuesList.add('Please Select');
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
    }
}