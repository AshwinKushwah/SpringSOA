trigger ContactTrigger on Contact (before insert, after insert) {
	
    if(Trigger.isInsert && Trigger.isAfter){
        //method to update the No of Contacts Field on Related Account
        ContactTriggerHandler.updateNoOfContacts(Trigger.New);
    }
}