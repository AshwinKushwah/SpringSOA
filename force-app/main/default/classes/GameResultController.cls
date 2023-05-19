public with sharing class GameResultController {
    
    @AuraEnabled
    public static List<Word_Shuffle__c> gameResults(){
        //get the current user ID
       String userId = UserInfo.getUserId();
       List<Word_Shuffle__c> results = [Select Id, Name, Result__c, Mode__c , CreatedDate
       FROM Word_Shuffle__c
       WHERE CreatedById = : userId
       ORDER BY CreatedDate DESC
       ];
       return results;

    }
}