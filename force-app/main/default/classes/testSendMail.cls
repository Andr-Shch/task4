@isTest
private class testSendMail {

    static testmethod void checkTrigger() {
    Application__c app = new Application__c(Name='FORtest', Email__c='ssdws@gmail.com', Status__c='Created');
    insert app;
    System.assertEquals(0,Limits.getFutureCalls(), 'fututure  executed');
    app.Status__c = 'Processed';
    app.Email__c='sensor121@gmail.com';
    Test.startTest();
    Database.update(app);
    System.assertEquals(1,Limits.getFutureCalls(), 'No fututure');
    Test.stopTest();
 }

    static testmethod void checkFuture(){
       Application__c appAproved = new Application__c(Name='Loan Yes', Email__c='sesw@mail.com',Status__c = 'Processed', IsEligible__c= true);
       Application__c appNotAproved = new Application__c(Name='Loan No', Email__c='ses@mail.com', Status__c = 'Processed', IsEligible__c = false);
       insert appAproved;
       insert appNotAproved;
     
       Test.startTest();
       taskSix.sendEmail(appNotAproved.Id);
       System.assertEquals(1, Limits.getFutureCalls(), 'No email with docline');

       taskSix.sendEmail(appAproved.Id);
       System.assertEquals(2,Limits.getFutureCalls(), 'No email with aprove');
       Test.stopTest();
       
    }
}
