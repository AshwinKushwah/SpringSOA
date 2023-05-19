public class SpringSOAAPI {
	
    public static void getData(){
        Http ht = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
        req.setMethod('GET');
        
        HttpResponse res = ht.send(req);
        Map<String, Object> jsonBody = (Map<String,Object>)json.deserializeUntyped(res.getBody());
        
        System.debug('The result is --'+ jsonBody);
    }
}