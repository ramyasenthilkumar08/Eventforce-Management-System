@isTest
public class EventForceTestFactory {
    public static Venue__c venue(String name){
        Venue__c v = new Venue__c(Name=name, Capacity__c=200, Availability_Status__c='Available');
        insert v;
        return v;
    }
    public static Event__c event(String name, Id venueId, Date d, String status){
        Event__c e = new Event__c(Name=name, Event_Type__c='Wedding', Event_Date__c=d,
                                  Event_Status__c=status, Venue__c=venueId);
        insert e;
        return e;
    }
}
