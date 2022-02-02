import { LightningElement, track } from 'lwc';

export default class Modal extends LightningElement {
    value = 'inProgress';
    status = 'In Progress'
    @track openModal = false;

    showModal() {
        this.openModal = true;
    }
    closeModal() {
        this.openModal = false;
    }

    get options() {
        return [
            { label: 'None', value: 'NONE', default:'true' },
            { label: 'No', value: 'NO' },
            { label: 'Yes', value: 'YES' },
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
        this.value = event.detail.value;
    }
    handleChangeStatus(event) {
        this.status = event.detail.value;
    }
}