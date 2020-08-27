public class CovidWrapper {
    @AuraEnabled public List<Series1> statewise;
    @AuraEnabled public List<tested> tested;
    
 
    public CovidWrapper(){
        statewise = new List<Series1>();
        tested = new List<tested>();
       
    }
    public class Series1{
       @AuraEnabled public string state{get;set;}
       @AuraEnabled public string active{get;set;}
       @AuraEnabled public string confirmed{get;set;}
       @AuraEnabled public string deaths{get;set;}
       @AuraEnabled public string lastupdatedtime{get;set;}
       @AuraEnabled public string recovered{get;set;}
       @AuraEnabled public string statecode{get;set;}
       @AuraEnabled public Decimal  recoveredperc{get;set;}
       @AuraEnabled public Decimal  deathperc{get;set;}
     }
    
    public class tested{
        @AuraEnabled public string source{get;set;}
        @AuraEnabled public string samplereportedtoday{get;set;}
                }
    
    
    
}