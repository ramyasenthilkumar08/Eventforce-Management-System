@isTest
private class VenueStatusHelperTest {
    @isTest static void confirmedEventReservesVenue(){
        Venue__c v = EventForceTestFactory.venue('Hall A');
        EventForceTestFactory.event('E1', v.Id, Date.today().addDays(10), 'Confirmed');
        System.assertEquals('Reserved', [SELECT Availability_Status__c FROM Venue__c WHERE Id = :v.Id].Availability_Status__c);
    }
    @isTest static void canceledEventReleasesVenue(){
        Venue__c v = EventForceTestFactory.venue('Hall B');
        Event__c e = EventForceTestFactory.event('E2', v.Id, Date.today().addDays(10), 'Confirmed');
        e.Event_Status__c = 'Canceled';
        update e;
        System.assertEquals('Available', [SELECT Availability_Status__c FROM Venue__c WHERE Id = :v.Id].Availability_Status__c);
    }
}
