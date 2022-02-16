public class checkProcessed implements
Database.Batchable<sObject>, Database.Stateful{
    public Database.QueryLocator start(Database.BatchableContext bc){
       //date d = System.today().addDays(-7);
        return Database.getQueryLocator('SELECT Id, IsEligible__c, Status__c FROM Application__c WHERE createdDate = N_DAYS_AGO:8');
    }
    public void execute(Database.BatchableContext bc, List<Application__c> scope){
        for (Application__c app : scope) {
            if(app.Status__c!='Processed'){
               app.Status__c = 'Processed';
               app.IsEligible__c = false;
            }
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('No error');
    }
}
