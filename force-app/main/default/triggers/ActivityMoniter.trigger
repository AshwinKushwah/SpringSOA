trigger ActivityMoniter on Student_Activities__c (after insert, after delete, after update) {
    
    List <Activity_Master__c> updateList = new List<Activity_Master__c>();
        
    //Task 1 Insert and Task 2 
    if(Trigger.isInsert){
        
        List<Id> idList = new List<Id>();
        for(Student_Activities__c stu  : Trigger.New){
            idList.add(stu.Activity_Master__c);
        }
        
        Activity_Master__c [] acList = [Select Id, No_of_Students_Enrolled__c,Activity_Start_Date__c, Activity_End_Date__c From Activity_Master__c Where Id IN : idList];
         
        
        for(Activity_Master__c acm  : acList){
           
            //increment the enrolled student 
           acm.No_of_Students_Enrolled__c =  acm.No_of_Students_Enrolled__c + 1; 
           updateList.add(acm); 
            
           Boolean isEnrollmentOk = true;
            
           Integer Year =  acm.Activity_Start_Date__c.Year();
           Integer Month = acm.Activity_Start_Date__c.Month();
            
            //if Year and Month are equal than check for 2 days diff
            if(Year == System.today().Year() && Month == System.today().Month()) {
                
                Integer day = acm.Activity_Start_Date__c.Day();
                
                if(day <= System.today().Day()) {
                    
                    isEnrollmentOk = false;
                }
            }
            
            //generate an Error Message in Apex -- throwing Exception
            if(!isEnrollmentOk){
              //code for Generating the Error Message
            }
        }
        
        //checking for Enrollment is closed or not for particular activity for which the Student Acivity is inserted
        
        
        
    }
    //Task 1 Delete
    
    if(Trigger.isDelete){
        List<Id> idList = new List<Id>();
        for(Student_Activities__c stu  : Trigger.old){
            idList.add(stu.Activity_Master__c);
        }
        
         Activity_Master__c [] acList = [Select Id, No_of_Students_Enrolled__c From Activity_Master__c Where Id IN : idList];
        
        for(Activity_Master__c acm  : acList){
            //decrement the enrolled student
           acm.No_of_Students_Enrolled__c =  acm.No_of_Students_Enrolled__c - 1; 
           updateList.add(acm); 
        }
        
    }
	
    
    //Task - 3 and 4
    if(Trigger.isUpdate){
        List<Id> idList = new List<Id>();
        for(Student_Activities__c stu  : Trigger.New){
            
            if(stu.Participated__c == true){
                 idList.add(stu.Activity_Master__c);
            }
            
                    Activity_Master__c [] acList = [Select Id, No_of_Students_Enrolled__c,Activity_Start_Date__c, Activity_End_Date__c From Activity_Master__c Where Id IN : idList];
            
            for(Activity_Master__c acm  : acList){
                 acm.No_of_Students_Participated__c = acm.No_of_Students_Participated__c + 1;
                 updateList.add(acm); 
            	
            
           Boolean isEnrollmentOk = true;
            
           Integer Year =  acm.Activity_Start_Date__c.Year();
           Integer Month = acm.Activity_Start_Date__c.Month();
           Integer day = acm.Activity_Start_Date__c.Day();
            //if Year and Month are equal than check for 2 days diff
            if(Year < System.today().Year() || Month < System.today().Month() || Day < System.today().Day()) {
                
              ///generate error for code 4 
              
            }
            
           
        }
        }
        
        
    }
    
    //updating the final List
    update updateList;
    
}