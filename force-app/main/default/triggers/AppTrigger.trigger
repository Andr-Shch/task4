trigger AppTrigger on Application__c (before update, after update) {
  
 // AppTriggerService handle = new   AppTriggerService(Trigger.New,Trigger.oldMap );
  if (trigger.isBefore){
    for(Application__c app : Trigger.New){
        if(app.IsEligible__c == true){
            app.Status__c = 'Processed';
        }
    // handle.beforeUpdate();
      }
   }
   if (trigger.isAfter){
      If(System.isBatch()) return;
      for(Application__c app : Trigger.New){
       Application__c oldApp = Trigger.oldMap.get(app.Id);
       if(app.Status__c != oldApp.Status__c && app.Status__c=='Processed') {
        taskSix.sendEmail(app.Id);
      }
   }
}
}