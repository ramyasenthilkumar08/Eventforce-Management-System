@isTest
private class BatchCompleteEventsTest {
    @isTest static void pastEventsBecomeCompleted(){
        Venue__c v = EventForceTestFactory.venue('Hall E');
        Event__c past = EventForceTestFactory.event('Past', v.Id, Date.today().addDays(-5), 'Planned');
        Event__c future = EventForceTestFactory.event('Future', v.Id, Date.today().addDays(5), 'Planned');
        Test.startTest();
        Database.executeBatch(new BatchCompleteEvents(), 200);
        Test.stopTest();
        System.assertEquals('Completed', [SELECT Event_Status__c FROM Event__c WHERE Id = :past.Id].Event_Status__c);
        System.assertEquals('Planned', [SELECT Event_Status__c FROM Event__c WHERE Id = :future.Id].Event_Status__c);
    }
    @isTest static void schedulerRuns(){
        Test.startTest();
        String jobId = System.schedule('Test Daily Event Completion', '0 0 20 * * ?', new ScheduleCompleteEvents());
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }
}
