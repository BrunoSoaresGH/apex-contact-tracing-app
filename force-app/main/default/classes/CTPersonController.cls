public with sharing class CTPersonController {

    /** 
     * @param mobileNumber
     * @return token
     */
    public static String getToken(String mobileNumber){
        Blob value = Blob.valueOf(mobileNumber);
        Blob hash = Crypto.generateDigest('MD5', value);

        //Getting the string value of hash blob
        return EncodingUtil.base64Encode(hash);
    }

    /** 
     * Get 100 contacts with recent health status change
     * @return List<Person__c> 
    */
    public static List<Person__c> getRecentHealthChanges(){
        return [
            SELECT 
                Id, Name, Health_Status__c, Mobile_c, Status_Update_Date_c, Token_c
            FROM
                Person__c
            ORDER BY
                Status_Update_Date_c DESC
            NULLS LAST LIMIT 100         
        ];
    }

    /**
     * Get people by Name, Mobile or Token
     * @param searchTerm
     * @return List<Person__c> 
     */
    public static List<Person__c> searchPeople(String searchTerm){
        searchTerm = searchTerm + '%';
        List<Person__c> people = [
            SELECT 
                Id, Name, Health_Status__c, Mobile_c, Status_Update_Date_c, Token_c
            FROM
                Person__c
            WHERE Name LIKE :searchTerm
            OR Mobile_c LIKE :searchTerm
            OR Token_c LIKE :searchTerm
            ORDER BY Status_Update_Date_c DESC
        ];

        if(people != null && people.size() > 0){
            return people;
        }

        return null;
    }

    /**
     * Search a person by id
     * @return Person__c
     */
    public static Person__c getPersonById(String personId){
        List<Person__c> people = [
            SELECT 
                Id, Name, Health_Status__c, Mobile_c, Status_Update_Date_c, Token_c
            FROM
                Person__c
            WHERE Id = :personId
        ];

        if(people != null && people.size() > 0){
            return people[0];
        }
        return null;
    }

}
