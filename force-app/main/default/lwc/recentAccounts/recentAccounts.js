import { LightningElement, wire, track } from 'lwc';
import getRecentAccounts from '@salesforce/apex/RecentAccountsController.getRecentAccounts';

const columns = [
    { label: 'Name', fieldName: 'name', type:'text' },
    
   // { label: 'No of Contacts', fieldName: 'No_of_Contacts__c', type: 'number' }
   
];

export default class RecentAccounts extends LightningElement {
    @track accountList;
    //uses wire adapter to get the accounts Data
    @wire(getRecentAccounts) wiredAccounts({data, error}){
        if(data){
            this.accountList = data;
            console.log('the data is -- '+ JSON.stringify(data));
        } else{
            console.log('error occured --'+ error);
        }
    }
    
    connectedCallback(){
      //  console.log('the account lsit --'+ accountList);
    
    }
   
}