global  class taskSix {
   @future
    public static void sendEmail(Id recordId) {
        Application__c app = [SELECT Id, Name, Email__c, IsEligible__c FROM Application__c WHERE Id = :recordId LIMIT 1];
        System.debug(app);
        Messaging.reserveSingleEmailCapacity(1);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {app.Email__c}; 
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Salesforce Support');
        mail.setReplyTo('support@acme.com');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        if(app.IsEligible__c==true){
            mail.setPlainTextBody('Wow! A loan is allowed for you!'); 
        } else {
            mail.setPlainTextBody('Sorry, but we cannot give you a loan this time.'); 
        }
        mail.setSubject('Loan '+app.Id);
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                  + results[0].errors[0].message);
        }
    }
}
