import {LightningElement,api,track,wire} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { getFieldValue } from 'lightning/uiRecordApi';
import getDomains from '@salesforce/apex/CheckboxListController.getPiklistValues';

import DOMAINS from '@salesforce/schema/Account.Domains__c';

export default class MultiCheckbox extends LightningElement {
    @api objectApiName;
    @api recordId;

    @wire(getFieldValue) domains;
    
    value = ['option1'];

    @track options = this.domains;

    get selectedValues() {
        return this.value.join(',');
    }

    handleChange(e) {
        console.log(e.detail);
        this.value = e.detail.value;
    }
}