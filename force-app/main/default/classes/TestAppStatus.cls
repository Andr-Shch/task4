@isTest
public class TestAppStatus {
    @isTest static void setTrue(){
        Application__c app = new Application__c(Name='Test App', Status__c='Created', Email__c='sen@mail.com');
        //start test
     
        try{
          //create record  
          insert app;
          app.IsEligible__c = true;
          //update to fire trigger  
          Test.startTest();
          update app;
          Test.stopTest();
          Application__c updateApp = [SELECT Name,Status__c FROM Application__c WHERE Name='Test App'];
           
          System.assertEquals('Processed', updateApp.Status__c);
        }catch(DmlException dmlEx){
            System.debug(dmlEx.getDmlMessage(0));
        }
        
    }
    
}