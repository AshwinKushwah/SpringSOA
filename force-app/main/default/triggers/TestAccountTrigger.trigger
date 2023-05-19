trigger TestAccountTrigger on Account (before insert, before update, before delete) {
    for(Account a : Trigger.New){
       
        a.Site = 'Site From Trigger Updated';
    }
}