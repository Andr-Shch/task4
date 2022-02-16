public with sharing class AppTriggerService {
    final List<Application__c> newRecords;
    final Map<Id, Application__c> oldMap;
    public AppTriggerService(List<Application__c> newRecords, Map<Id, Application__c> oldMap)
    {
        this.newRecords = newRecords;
        this.oldMap = oldMap;
    }

    public void beforeUpdate(){
        for(Application__c app : newRecords){
            if(app.IsEligible__c == true){
                app.Status__c = 'Processed';
            }
        }
    }
}

// public with sharing class EventTriggerHandler
// {
//     @TestVisible static Boolean bypassTrigger = false;

//     final List<Event> newRecords;
//     final Map<Id, Event> oldMap;
//     public EventTriggerHandler(List<Event> newRecords, Map<Id, Event> oldMap)
//     {
//         this.newRecords = newRecords;
//         this.oldMap = oldMap;
//     }

//     public void beforeInsert()
//     {
//         if (bypassTrigger) return;

//         CaseService.doStuff1();
//     }