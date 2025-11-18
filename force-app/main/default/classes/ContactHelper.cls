public with sharing class ContactHelper {
    
    public static void generateDummyJsonId(List<Contact> newContacts) {
        for (Contact con : newContacts) {
            if (con.DummyJSON_Id__c == null) {
                con.DummyJSON_Id__c = String.valueOf(Integer.valueOf((Math.random() * 100) + 1));
                System.debug(con);
            }
        }
    }

    public static void callGetDummyJsonApi(List<Contact> newContacts) {
        Set<Id> contactIdsForCallout = new Set<Id>();
        
        for (Contact con : newContacts) {
            if (con.DummyJSON_Id__c != null && Decimal.valueOf(con.DummyJSON_Id__c) <= 100) {
                //DummyJSONCallout.getDummyJSONUserFromId(con.Id);
                contactIdsForCallout.add(con.Id);
            }
        }

         if (!contactIdsForCallout.isEmpty()) {
            // Convert Set<Id> to comma-separated string
            String contactIdString = String.join(new List<Id>(contactIdsForCallout), ',');
            DummyJSONCallout.getDummyJSONUserFromId(contactIdString);
        }
    }
    
    public static void callPostDummyJsonApi(List<Contact> newContacts) {
        Set<Id> contactIdsForCallout = new Set<Id>();

        for (Contact con : newContacts) {
            if (con.DummyJSON_Id__c != null && Decimal.valueOf(con.DummyJSON_Id__c) > 100) {
                contactIdsForCallout.add(con.Id);
            }
        }
        
        // Queue the future method
        if (!contactIdsForCallout.isEmpty()) {
            for (Id contactId : contactIdsForCallout) {
                DummyJSONCallout.postCreateDummyJSONUser(contactId);
            }
        }
    }
}