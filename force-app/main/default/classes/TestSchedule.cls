@istest
private class TestSchedule {
    public static String CRON_EXP = '0 22 22 * * ?';
    @testSetup
    static void setup() {
        List<Application__c> Apps = new List<Application__c>();
        Datetime moreThanWeek = Datetime.now().addDays(-8);
        for (Integer i=0;i<50;i++) {
         Application__c app = new Application__c();
         app.Status__c = 'Created';
         app.Email__c = 'test'+i+'@mail.com';
         app.Name = 'Test '+i;
         insert app;
        
         Test.setCreatedDate(app.Id, moreThanWeek);
        
       
        
        }
       
        
    }
    @isTest
     static void test() {

        Test.startTest();
        
           checkProcessed uca = new checkProcessed();
           Id batchId = Database.executeBatch(uca);
           Test.stopTest();
        List<Application__c> Apps = [SELECT Id, createdDate, Status__c FROM Application__c WHERE Status__c != 'Processed'];
       
        System.assertEquals(0, Apps.size(), 'Not 0');
    }
}
