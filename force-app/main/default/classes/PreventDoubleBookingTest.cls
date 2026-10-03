@isTest
private class PreventDoubleBookingTest {
    @isTest static void secondEventSameVenueAndDateIsBlocked(){
        Venue__c v = EventForceTestFactory.venue('Hall C');
        Date d = Date.today().addDays(15);
        EventForceTestFactory.event('First', v.Id, d, 'Planned');
        Boolean blocked = false;
        try {
            EventForceTestFactory.event('Second', v.Id, d, 'Planned');
        } catch(DmlException ex){
            blocked = ex.getMessage().contains('already booked');
        }
        System.assert(blocked, 'Double booking should be blocked');
    }
    @isTest static void sameVenueDifferentDateIsAllowed(){
        Venue__c v = EventForceTestFactory.venue('Hall D');
        EventForceTestFactory.event('First', v.Id, Date.today().addDays(20), 'Planned');
        EventForceTestFactory.event('Second', v.Id, Date.today().addDays(21), 'Planned');
        System.assertEquals(2, [SELECT COUNT() FROM Event__c WHERE Venue__c = :v.Id]);
    }
}
