public class covidData {
    
    @AuraEnabled(cacheable=true) 
    public static object covidDetails(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://covid19-india-adhikansh.herokuapp.com/states');
        request.setMethod('GET');
        request.setHeader('content-type','application/json');
        HttpResponse response = http.send(request);        
        if (response.getStatusCode() == 200) {
            system.debug('response....()'+response.getBody());
            return response.getBody();
        }
        return null;
    }
    
    @AuraEnabled(cacheable=true) 
    public static object covidIndiaDetails(String state1){
        system.debug('state...'+state1);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.covid19india.org/data.json');
        request.setMethod('GET');
        request.setHeader('content-type','application/json');
        HttpResponse response = http.send(request);        
        if (response.getStatusCode() == 200) {
            system.debug('response....()'+response.getBody());
            CovidWrapper output =(CovidWrapper)JSON.deserialize(response.getBody(),CovidWrapper.class);
            system.debug('output....()'+output);
            return output;
        }
        return null;

    }
    
     @AuraEnabled
    public static object covidStateData(String state1){
        system.debug('state...'+state1);
        if(state1.contains('-7')){
            state1=state1.replace('-7','');
           
        }else if(state1.contains('-10')){
            state1=state1.replace('-10','');
            
        }else if(state1.contains('-8')){
            state1=state1.replace('-8','');
            
        }else if(state1.contains('-9')){
            state1=state1.replace('-9','');
            
        }
        system.debug('state...'+state1);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.covid19india.org/data.json');
        request.setMethod('GET');
        request.setHeader('content-type','application/json');
        HttpResponse response = http.send(request);        
        if (response.getStatusCode() == 200) {
            system.debug('response....()'+response.getBody());
            CovidWrapper output =(CovidWrapper)JSON.deserialize(response.getBody(),CovidWrapper.class);
            system.debug('output....()'+output);
            list<CovidWrapper.Series1> ser = new list<CovidWrapper.Series1>();
            for(CovidWrapper.Series1 o:output.statewise){
                if(String.isNotblank(state1) && (state1.equalsIgnorecase(o.state) || state1.equalsIgnorecase(o.statecode)) ){
                    CovidWrapper.Series1 s = new CovidWrapper.Series1();
                    s.active=o.active;
                    s.confirmed=o.confirmed;
                    s.deaths=o.deaths;
                    s.lastupdatedtime=o.lastupdatedtime;
                    s.recovered=o.recovered;
                    s.state=o.state;
                    s.statecode=o.statecode;
                    Decimal i=(Integer.valueOf(s.recovered)*100) / Integer.valueOf(s.confirmed);
                    s.recoveredperc = i;
                    Decimal i1=(Integer.valueOf(s.deaths)*100)/ Integer.valueOf(s.confirmed);
                    s.deathperc = i1;
                    ser.add(s);
                    break;
                    
                }
                
            }
            CovidWrapper w = new CovidWrapper();
            w.statewise=ser;
            if(w!=null && w.statewise.size()>0){
                return w;
            }else if(String.isNotblank(state1) && w!=null && w.statewise.size()==0){
                return 'Enter Valid State Name/ Code';
            }
            system.debug('ser..'+ser);
            return output;
        }
        return null;

    }
    @AuraEnabled
  public static object covidDistData(String state1){
        system.debug('state...'+state1);
        String st;
        if(state1.contains('-1') || state1.contains('-7')){
            st=state1.replace('-1','');
            st=state1.replace('-7','');
            system.debug('st...'+st);
        }
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.covid19india.org/state_district_wise.json');
        //request.setEndpoint('https://api.covidindiatracker.com/state_data.json');
      	request.setMethod('GET');
        request.setHeader('content-type','application/json');
        HttpResponse response = http.send(request);        
        if (response.getStatusCode() == 200) {
            system.debug('response....()'+response.getBody());
            Map<String, Object> responseResult = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('responseResult....()'+responseResult.get(st));
            return responseResult.get(st);
        }
        return null;

    }
    
    @AuraEnabled
    public static object covidDistrictData(String state1){
        system.debug('state...'+state1);
        String st;
         if(state1.contains('-7')){
            st=state1.replace('-7','');
            system.debug('st...'+st);
        }else if(state1.contains('-10')){
            st=state1.replace('-10','');
            system.debug('st...'+st);
        }else if(state1.contains('-8')){
            st=state1.replace('-8','');
            system.debug('st...'+st);
        }else if(state1.contains('-9')){
            st=state1.replace('-9','');
            system.debug('st...'+st);
        }
        if(st=='Andhra Pradesh'){
            state1='AP';
        }else if(st=='Telangana'){
            state1='TG';
        }else if(st=='Delhi'){
            state1='DL';
        }else if(st=='Maharashtra'){
            state1='MH';
        }else if(st=='Chandigarh'){
            state1='CH';
        }else if(st=='Dadra and Nagar Haveli and Daman and Diu'){
            state1='DN';
        }else if(st=='Andaman and Nicobar Islands'){
            state1='AN';
        }else if(st=='Goa'){
            state1='GA';
        }else if(st=='Gujarat'){
            state1='GJ';
        }else if(st=='Tamil Nadu'){
            state1='TN';
        }else if(st=='Uttar Pradesh'){
            state1='UP';
        }else if(st=='Rajasthan'){
            state1='RJ';
        }else if(st=='West Bengal'){
            state1='WB';
        }else if(st=='Madhya Pradesh'){
            state1='MP';
        }
        
        system.debug('state1...'+state1);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
       	request.setEndpoint('https://api.covid19india.org/v3/data.json');
      	request.setMethod('GET');
        request.setHeader('content-type','application/json');
       	//request.setEndpoint('https://api.covid19india.org/v2/state_district_wise.json');
        HttpResponse response = http.send(request);        
     if (response.getStatusCode() == 200) {
            system.debug('response....()'+response.getBody());
          	Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> meta1 = (Map<String, Object>) meta.get(state1);
         	system.debug('objects..'+meta1);
        
          Map<String, Object> meta2 = (Map<String, Object>)meta1.get('districts');
         system.debug('meta2..'+meta2);
         Map<string,string> data = new Map<string,string>();
         Map<string,wrapperData> dataLs = new Map<string,wrapperData>();
         
         District__c dis =[SELECT id,name,Districts__c FROM District__c where name=:state1 LIMIT 1];
         String s =dis.Districts__c;
         system.debug('s..'+s);
          list<String> sLst = s.split(';');
          list<wrapperData> wrapLst = new list<wrapperData>();
         for(String sp:sLst){
             system.debug('sp..'+sp);
             //data.put(sp,sp);
             Map<String, Object> meta3 = (Map<String, Object>)meta2.get(sp);
                system.debug('meta3..'+meta3);
               
                wrapperData wrapperObj;
             for(String key1 : meta3.keyset()) {
                 wrapperObj = new wrapperData();
                 String strResult = JSON.serialize(meta3.get('total'));
                 system.debug('strResult in for..'+strResult);
                 wrapperObj = (wrapperData) JSON.deserialize(strResult, wrapperData.class);
                 system.debug('wrapperObj...'+wrapperObj);
                 wrapperData wrapperObj1 = new wrapperData();
                 wrapperObj1.name=sp;
                 wrapperObj1.confirmed=String.valueOf(wrapperObj.confirmed);
                 wrapperObj1.deceased=String.valueOf(wrapperObj.deceased);
                 wrapperObj1.recovered=String.valueOf(wrapperObj.recovered);
                 wrapLst.add(wrapperObj1);
                 
                 
             }
             
         }
            system.debug('wrapLst dataLs...'+wrapLst);
             system.debug('data...'+data);
             for(wrapperData ls:wrapLst){
                dataLs.put(ls.name,ls);
             }
             system.debug('final dataLs...'+dataLs);
             list<wrapperData> wrLst = new list<wrapperData>();
             for(String key1 : dataLs.keyset()) {
                wrapperData wrapper = new wrapperData();
                wrapperData wrapper1 = dataLs.get(key1);
                wrapper.name=key1;
                wrapper.confirmed=wrapper1.confirmed;
                wrapper.deceased=wrapper1.deceased;
                wrapper.recovered=wrapper1.recovered;
                wrLst.add(wrapper);
             }
             system.debug('wrLst dataLs...'+wrLst);
           return wrLst;
        } 
       return null;
    }
    
     @AuraEnabled
    public static object covidDistrictData1(String state1){
        boolean flag=true;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
       // request.setEndpoint('https://api.covid19india.org/v3/data.json');
      	request.setMethod('GET');
       // request.setHeader('content-type','application/json');
       	request.setEndpoint('https://corona-virus-world-and-india-data.p.rapidapi.com/api_india');
        request.setHeader('x-rapidapi-host','corona-virus-world-and-india-data.p.rapidapi.com');
         request.setHeader('x-rapidapi-key','e29548aaa1msh6ef9c98cc34e233p1d13c2jsn9cfdb59ed35a');
         //request.setHeader('useQueryString',flag);
        HttpResponse response = http.send(request);        
     if (response.getStatusCode() == 200) {
         system.debug('response....()'+response.getBody());
        Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('meta..'+meta.get('AP'));
     }
        return null;
    }
    

    @AuraEnabled
    public static object getStateNames(String code){
        if(string.isNotblank(code)){
            system.debug('code....()'+code);
          String st = '%' + code + '%';
          system.debug('st....()'+st);
          return [SELECT State_Name__c FROM District__c WHERE State_Name__c like: st];
        }
       return null; 
    }
    
    public class wrapperData{
        @AuraEnabled public Total total;
        @AuraEnabled public string confirmed;
        @AuraEnabled public string deceased;
        @AuraEnabled public string recovered;
        @AuraEnabled public string name;
    }
    public class Total{
        @AuraEnabled public string confirmed;
        @AuraEnabled public string deceased;
        @AuraEnabled public string recovered;
    }
}