public with sharing class CTPersonTriggerHandler {
    
    /** 
     * Make sure that each new Person__c record 
     * has Health_Status__c = 'Green'
     * and a unique token  
    */
    public static void beforeInsert(List<Person__c> newRecords){
        for (Person__c person : newRecords) {
            person.Health_Status__c = 'Green';
            person.Token__c = CTPersonController.getToken(person.Mobile__c);
        }
    }

    /**
     * Make sure that each updated Person__c record
     * has a updated Status_Update_Date_c if this field
     * was changed.
     */
    public static void beforeUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldRecordsMap){
        for (Person__c person : newRecords) {
            if(person.Health_Status__c != oldRecordsMap.get(person.id).Health_Status__c){
                person.Status_Update_Date_c = Date.today();
            }
        }
    }
}
