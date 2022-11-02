public with sharing class CTLocationController {

    /**
     * Get the 100 Location__c with recent status changes
     * @return List<Location__c>
     */
    public static List<Location__c> getRecentStatusChanges(){
        return [
            SELECT 
                Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date_c, Status__c 
            FROM
                Location__c
            ORDER BY 
                Status_Update_Date__c DESC
            NULLS LAST LIMIT 100];
    }

    /**
     * Search a location by name, zipcode or address
     * @return List<Location__c>
     */
    public static List<Location__c> searchLocations(String searchTerm){
        return [
            SELECT 
                Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date_c, Status__c 
            FROM
                Location__c
            WHERE 
                Name = :searchTerm
            OR 
                Pincode__c = :searchTerm
            OR 
                Address__c = :searchTerm
            ORDER BY 
                Status_Update_Date__c DESC            
        ];    
    }

    /**
     * Search a location by id 
     * @return Location__c
     */
    public static Location__c getLocationById(String locationId){
        List<Location__c> locations = [
            SELECT 
                Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date_c, Status__c 
            FROM
                Location__c
            WHERE 
                Id = :locationId            
        ];

        if(locations.size() > 0 && locations != null){
            return locations[0];
        }

        return null;
    }

    /** 
     * Get count of locations in each status 
     * @return Map<String, Integer>
    */
    public static Map<String, Integer> getStatusCount(){
        Map<String, Integer> healthCountMap = new Map<String, Integer>();

        for(AggregateResult result : [SELECT Status__c status, Count(Id) total 
                                      FROM Location__c 
                                      GROUP BY Status__c]){
            healthCountMap.put(String.valueOf(result.get('status')),Integer.valueOf(result.get('total')));                                
        }

        return healthCountMap;
    }
}
