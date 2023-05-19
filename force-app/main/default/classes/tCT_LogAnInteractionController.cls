public class tCT_LogAnInteractionController {
	//@AuraEnabled public TaskWrapper taskWrapper{get;set;}
	//@AuraEnabled public FinalTaskWrapper finalTaskWrapper{get;set;}
   // @AuraEnabled public PicklistWrapper pickListWrap{get;set;}
/*    
@AuraEnabled
    public static List<String> getRMPickListValues(){
       List<String> pickListValuesList= new List<String>();
		Schema.DescribeFieldResult fieldResult = Schema.Task.Related_Metric__c.getDescribe();
		
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple){
			pickListValuesList.add(pickListVal.getLabel());
		}  
        
        return pickListValuesList;

    }
    
@AuraEnabled
    public static List<String> getFA(String recordID){
       List<TCT_Focus_Area__c> FAList=[Select id ,Name,status__c from TCT_Focus_Area__c 
                                        where clinic__c=:recordID AND 
                                        status__c IN('Active','Pending','','Complete - Resolved','Complete - Not resolved') 
                                        order by Name];
		List<String> FANames = new List<String>();
		for(TCT_Focus_Area__c f:FAList){
			FANames.add(f.name);
		}
        return FANames;
	}
    
    /*
* @ApexMethod: getFocusAreaDetails
* @Description: This method retsrieves the Focus Area Details
*/
/*
    @AuraEnabled
    public static tCT_LogAnInteractionController getFieldsDetails(String recordID) { 
	
		tCT_LogAnInteractionController tctInteractionController=new tCT_LogAnInteractionController();
        tctInteractionController.taskWrapper=new tCT_LogAnInteractionController.TaskWrapper();
        //tctInteractionController.pickListWrap=new tCT_LogAnInteractionController.PicklistWrapper();
		
		 //Variables to get all picklist values of Task object
       // Map<String, Schema.RecordTypeInfo> recordTypes = Schema.SObjectType.Task.getRecordTypeInfosByName();
		//Id logInteractionRecTypeId = recordTypes.get('TCT Interaction').getRecordTypeId();
        //Task taskObject=null;
		//taskObject = (Task)Task.sObjectType.newSObject(logInteractionRecTypeId,true);
        
        Schema.DescribeFieldResult itrSubjectField =Task.Subject.getDescribe();
        Schema.DescribeFieldResult itrTypeField =Task.Type.getDescribe();
		Schema.DescribeFieldResult itrContactedField =Task.Contacted__c.getDescribe();
        Schema.DescribeFieldResult itrRelatedMetricField =Task.Related_Metric__c.getDescribe();
		
		List<Schema.PicklistEntry> plSubject = itrSubjectField.getPicklistValues();
		List<Schema.PicklistEntry> plType = itrTypeField.getPicklistValues();
		List<Schema.PicklistEntry> plContacted = itrContactedField.getPicklistValues();
        List<Schema.PicklistEntry> plRelatedMetric = itrRelatedMetricField.getPicklistValues();
		
		//setting in wrapper
        for( Schema.PicklistEntry f : plSubject)
        {
            customMultiWrapper pa=new customMultiWrapper();
            pa.Id=f.getLabel();
            pa.Name=f.getValue();
            tctInteractionController.taskWrapper.subjectList.add(pa);
        }    
		//setting in wrapper
        for( Schema.PicklistEntry f : plType)
        {
            customMultiWrapper pa=new customMultiWrapper();
            pa.Id=f.getLabel();
            pa.Name=f.getValue();
            tctInteractionController.taskWrapper.typeList.add(pa);
        }  
		
		//setting in wrapper
        for( Schema.PicklistEntry f : plContacted)
        {
            customMultiWrapper pa=new customMultiWrapper();
            pa.Id=f.getLabel();
            pa.Name=f.getValue();
            tctInteractionController.taskWrapper.ContactedList.add(pa);
        }  
        
        //setting in wrapper
        for( Schema.PicklistEntry f : plRelatedMetric)
        {
            customMultiWrapper pa=new customMultiWrapper();
            pa.Id=f.getLabel();
            pa.Name=f.getValue();
            tctInteractionController.taskWrapper.RelatedMetricList.add(pa);
        } 
        
        /* Focus Area */
        /*
        List<TCT_Focus_Area__c> FAList=[Select id ,Name,status__c from TCT_Focus_Area__c 
                                        where clinic__c=:recordID AND 
                                         status__c IN('Active','Pending','','Complete - Resolved','Complete - Not resolved') 
                                        order by Name];
		
        for(TCT_Focus_Area__c f : FAList)
        {
            customMultiWrapper pa=new customMultiWrapper();
            pa.Id=f.id;
            pa.Name=f.name;
            tctInteractionController.taskWrapper.FocusAreaList.add(pa);
        } 
        system.debug('--tctInteractionController--'+tctInteractionController);
        User oUser = [select id,Name FROM User Where id =: userInfo.getUserId()];
        tctInteractionController.taskWrapper.AssignedTo =oUser.name;
        
        Account clinic = [select id,Name FROM Account Where id =: recordID];
        tctInteractionController.taskWrapper.RelatedTo =clinic.Name;
        
		return tctInteractionController;
	}
 /*
* @ApexMethod: createTask
* @Description: This method creates the Focus Area records for 'tCT Focus Area' record type
*/   
    /*
    @AuraEnabled
    public static String createTask(String recordID,String logInteractionDetails1){
        
        tCT_LogAnInteractionController.FinalTaskWrapper fawrap = (tCT_LogAnInteractionController.FinalTaskWrapper)JSON.deserialize(logInteractionDetails1, tCT_LogAnInteractionController.FinalTaskWrapper.class);
		
        Task_Summary__c tasksummary= new Task_Summary__c();
        
        Task taskToBecreated = new Task();
        //related to is account
        taskToBecreated.Patient__c=recordID;
        taskToBecreated.type=fawrap.itrType;
        taskToBecreated.subject=fawrap.itrSubject;
        taskToBecreated.Contacted__c=fawrap.itrContacted;
        taskToBecreated.Related_Metric__c=fawrap.itrRelatedTo;
        //taskToBecreated.Assigned_To__c=fawrap.itrAssignedTo; is not writable
        if(fawrap.itrFA != null && fawrap.itrFA.size()>0){
            tasksummary=tCT_LogAnInteractionController.getCreateFATSJunobject(fawrap.itrFA);
            taskToBecreated.Task_Summary__c=tasksummary.Id;
        }
        if(!String.isBlank(fawrap.itrNotes)){
            createNote(recordID,fawrap.itrNotes);
        }
        
        insert taskToBecreated;
        if(taskToBecreated.Task_Summary__c!= null){
            tasksummary.Task_Id__c=taskToBecreated.Id;
        	update tasksummary;
        }
        
        system.debug('--taskToBecreated--'+taskToBecreated);
        system.debug('--tasksummary--'+tasksummary);
        return 'test';
    }
/*
* @ApexMethod: getCreateFATSJunobject 
* @Description: This method create junction Object for FA and Task Summary
*/   
    /*
    @AuraEnabled
    public static Task_Summary__c getCreateFATSJunobject(List<String> FAList){
        Task_Summary__c ts= new Task_Summary__c();
        insert ts;
        List<TCT_Focus_Area__c> focuAreaList=[select id,name from TCT_Focus_Area__c where name in:FAList];
        List<FA_TaskSummary__c> faTsJobject = new List<FA_TaskSummary__c>();
        for(TCT_Focus_Area__c faName:focuAreaList){
            FA_TaskSummary__c faTsObj = new FA_TaskSummary__c();
            faTsObj.Task_Summary__c=ts.id;
            faTsObj.id=faName.id;
            faTsJobject.add(faTsObj);
        }
        insert faTsJobject;
        system.debug('--faTsJobject--'+faTsJobject);
        return ts;
    }
    
/*
* @ApexMethod: createNote 
* @Description: This method create Note Object for
*/   
    /*
    @AuraEnabled
    public static void createNote(String recordID,String noteComments){
        string noteType='Tactical Care Note';
        String subjectNote='Clinic Assessment/Visit';
        Note__c notes =new Note__c();
        notes.Clinic__c=recordID;
        notes.TCT_Subject__c=subjectNote;
        notes.Notes__c=noteComments;
        notes.TCT_Type__c=noteType; 
        notes.recordTypeId=Schema.SObjectType.Note__c.getRecordTypeInfosByName().get('TCT Notes').getRecordTypeId();
        insert notes;
         system.debug('--notes--'+notes);
    }
	
	public Class FinalTaskWrapper{
        @AuraEnabled public String itrSubject;
        @AuraEnabled public String itrType;
        @AuraEnabled public String itrContacted;
        @AuraEnabled public String itrNotes;
        @AuraEnabled public String itrAssignedTo;
        @AuraEnabled public List<String> itrFA;
        @AuraEnabled public List<String> itrRelatedMetric;
        @AuraEnabled public String itrRelatedTo;
    }
	
	Public Class TaskWrapper{
        @AuraEnabled public List<customMultiWrapper> subjectList=new List<customMultiWrapper>(); 
        @AuraEnabled public List<customMultiWrapper> typeList=new List<customMultiWrapper>();
        @AuraEnabled public List<customMultiWrapper> ContactedList=new List<customMultiWrapper>();
        @AuraEnabled public List<customMultiWrapper> RelatedMetricList=new List<customMultiWrapper>();
        @AuraEnabled public List<customMultiWrapper> FocusAreaList=new List<customMultiWrapper>();
        @AuraEnabled public String RelatedTo;
        @AuraEnabled public String AssignedTo;
        
    }
	Public Class customMultiWrapper{
        @AuraEnabled public String Id;
        @AuraEnabled public String Name;
        @AuraEnabled public Boolean flag;
    }
	*/
}