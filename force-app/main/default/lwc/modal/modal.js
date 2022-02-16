import { LightningElement, track, api, wire } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Modal extends LightningElement {
    eligible=null;
    status = 'In Progress';
    disabled = false;
    @track openModal = false;
    @api recordId;
    @api application;
   
    showModal() {
        if(this.application.IsEligible__c == true){
            this.eligible=true
        } else {
            this.eligible=null
        }
        if (this.application.Status__c === 'Processed'){
            this.disabled = true
            this.status = 'Processed'
            if(this.application.IsEligible__c == false){
                this.eligible=false
            }
        }
        
        this.openModal = true;
    }
    closeModal() {
        this.openModal = false;
    }

    get options() {
        return [
            { label: 'None', value: null },
            { label: 'No', value: false },
            { label: 'Yes', value: true },
        ];
    }
    get optionsStatus() {
        return [
            { label: 'Created', value: 'Created' },
            { label: 'In Progress', value: 'In Progress' },
            { label: 'Processed', value: 'Processed' },
        ];
    }

    handleChange(event) {
     //   console.log(this.application);
     console.log(event.detail.value);
     switch(event.detail.value){
        case "true": 
        this.eligible = true;
          return;

        case "false": 
        this.eligible = false;
          return;

        default: 

          return 
    }
    
       
    }
    handleChangeStatus(event) {
        this.status = event.detail.value;
    }
   
    updateApp (){
   
        const allValid = [...this.template.querySelectorAll('lightning-combobox')]
        .reduce((validSoFar, inputCmp) => {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);
        this.template.querySelectorAll('lightning-combobox')
        console.log( this.template.querySelectorAll('lightning-combobox'));
         console.log(allValid); 
         if(allValid){
         
         let fields = {
             Id: this.recordId,
            // Name: this.application.name,
             Status__c: this.status,
             IsEligible__c : this.eligible
        }


        
       const recordInput = { fields };
       console.log(recordInput);
        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            console.log(error);
        });
        this.openModal = false;
    } else {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Something is wrong',
                message: 'No NONE value',
                variant: 'error'
            })
         );
    }
} 
    
}
   

