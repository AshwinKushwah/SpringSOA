trigger TestContactTrigger on Contact (before insert,before update, before delete) {
	
    System.debug('New variables --'+ Trigger.New);
    System.debug('Old Variables --'+Trigger.old);
	
    Map<Id, List<Contact>> accContactMap = new Map<Id, List<Contact>>();
    if(Trigger.isInsert || Trigger.isUpdate){
       for(Contact con : Trigger.New){
       
        // Account acc = con.AccountId;
        if(accContactMap.containsKey(con.AccountId)){
            accContactMap.put(con.AccountId,new List<Contact>());
        }
     } 
    }    
    
	if(Trigger.isDelete){
        for(Contact con : Trigger.Old){
    	 accContactMap.put(con.AccountId,new List<Contact>());
        }
     }
    List<Contact> baseContactList = [Select Id, Name, LastName From Contact Where AccountId IN : accContactMap.keySet()];
    
    for(Contact con : baseContactList){
        List<Contact> cList = accContactMap.get(con.AccountId);
        cList.add(con);
        accContactMap.put(con.AccountId, cList);
    }
}