public class CovidDistrictWrapper {
    @AuraEnabled public List<States> state;
    @AuraEnabled public List<DistrictData> districtData{get;set;} 
    public class States{
        @AuraEnabled public string state{get;set;}
       // @AuraEnabled public List<DistrictData> districtData{get;set;}    
    }
    
    public class DistrictData{
        @AuraEnabled public List<Districts> districts;
    }
    
    public class Districts{
        @AuraEnabled public string name{get;set;}
        @AuraEnabled public string confirmed{get;set;}
        @AuraEnabled public string recovered{get;set;} 
    }
    

}