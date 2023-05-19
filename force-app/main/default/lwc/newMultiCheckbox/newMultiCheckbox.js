import { LightningElement, wire, track, api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import DOMAINS_FIELD from '@salesforce/schema/Account.Domains__c';
import save from '@salesforce/apex/CheckboxListController.saveRecord';
import selectedCheckbox from '@salesforce/apex/CheckboxListController.selectedCheckbox';
import { getRecord,getPicklistValues,getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class NewMultiCheckbox extends LightningElement {

    @api recordId;
    @api objectApiName;
    @track value = [];
    @track optionsValue = [];



    connectedCallback(){
      //get the selected values
      this.saveSelectedValues();
     }
    

    saveSelectedValues(){
      selectedCheckbox({recordId:this.recordId})
      .then((result)=> {
        this.value = result; // assigning the result to the values
        console.log("value array : ", this.value);
        console.log("Selected Values : " , result);
      })
      .catch((error) => {
        console.log("Error in connected callback ", error);
      })
    }

    //getting the objectInfo using the standard getObjectInfo
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
     objectInfo; 

     //getting the picklist values using the standard getPicklistValues
    @wire(getPicklistValues, { recordTypeId: "$objectInfo.data.defaultRecordTypeId" , fieldApiName: DOMAINS_FIELD })
     wiredDatae({error, data}){
         if(data){
             for(let i=0; i<data.values.length; i++){
                this.optionsValue.push({label:data.values[i].value, value:data.values[i].value});
            };
         }
         else if(error){
             console.log(error);
         }
     }

    //imperatively calling the apex function and send record to save data
     onSaveRecord() {
        alert('Save is clicked');
        let  res = "";
        for(let i = 0; i < this.value.length; i++) {
            res = res.concat(this.value[i]);
            if(i < this.value.length-1){
                res = res.concat(";");
            }
 
        }
        //save function defined on apex controller
        save({recordId:this.recordId, values: res}) 
        .then(result => {
            console.log('result => ' , result);
        })
        .catch(error => {
            console.log('error');
        });

     }

    //selectedValues getter
    get selectedValues() {
        return this.value.join(',');
    }

    //updating the value based on user's choice
    handleChange(e) {
        this.value = e.detail.value;
    }
}