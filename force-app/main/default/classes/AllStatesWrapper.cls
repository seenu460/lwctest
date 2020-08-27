public class AllStatesWrapper {
    @AuraEnabled public list<India> state_wise;
    
     public class India{
        @AuraEnabled public List<districtData> districts;
         @AuraEnabled public string state{get;set;}
        @AuraEnabled public Double active{get;set;}
        @AuraEnabled public Double confirmed{get;set;} 
         @AuraEnabled public Double recovered{get;set;} 
          @AuraEnabled public Double deaths{get;set;} 
    }
    public class districtData{
        @AuraEnabled public string id{get;set;}
        @AuraEnabled public string name{get;set;}
        @AuraEnabled public Double confirmed{get;set;}
       // @AuraEnabled public string recovered{get;set;} 
    }

}