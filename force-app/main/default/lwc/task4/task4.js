import { LightningElement, api, track, wire } from 'lwc';
import {getRecord, getFieldValue, updateRecord} from 'lightning/uiRecordApi';

const FIELDS = [ 'Application__c.Name','Application__c.IsEligible__c','Application__c.Status__c'];

export default class ShowAccount extends LightningElement {
    
    
    @api strRecordId;
    application = {};
    @wire(getRecord, { recordId: '$strRecordId', fields: FIELDS })
     getApp({error, data}){
         if(error){
             console.log(error.body);
         } else if(data){
            this.application.name = data.fields.Name.value
            this.application.IsEligible__c = data.fields.IsEligible__c.value
            this.application.Status__c = data.fields.Status__c.value
         }
     }

    getInfo (){
        console.log(this.application);
        console.log(this.application.error.body.message);
    }
    
}