/**
    Name : SampleAPIResult
    Author : Nidhi Vyas
    Date : 11 Nov, 2020
    Description : This apex class is used to display sample API result.
**/
public class SampleAPIResult {
    public static string requestURL = 'https://postman-echo.com/get?foo1=bar1&foo2=bar2' ;
   
    public static void callAPI(){
         
        Http http = new Http();
       
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestURL);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(120000);
       
        //making callout
        HttpResponse response = http.send(request);
        system.debug(response.getBody());
        ResponseWrapper res = ResponseWrapper.parse(response.getBody()) ;
       
        System.debug('args :: ');
        System.debug('args.foo1 :: ' + res.args.foo1 );
        System.debug('args.foo2 :: ' + res.args.foo2 );
        System.debug('headers :: ');
        System.debug('headers.x-forwarded-proto :: ' + res.headers.x_forwarded_proto);
        System.debug('x-forwarded-port :: ' + res.headers.x_forwarded_port);
        System.debug('host :: ' + res.headers.host);
        System.debug('x-amzn-trace-id :: ' + res.headers.x_amzn_trace_id);
        System.debug('upgrade-insecure-requests :: ' + res.headers.upgrade_insecure_requests);
        System.debug('user-agent :: ' + res.headers.user_agent);
        System.debug('accept :: ' + res.headers.accept);
        System.debug('sec-fetch-site :: ' + res.headers.sec_fetch_site);
        System.debug('sec-fetch-mode :: ' + res.headers.sec_fetch_mode);
        System.debug('sec-fetch-user :: ' + res.headers.sec_fetch_user);
        System.debug('sec-fetch-dest :: ' + res.headers.sec_fetch_dest);
        System.debug('accept-encoding :: ' + res.headers.accept_encoding);
        System.debug('accept-encoding :: ' + res.headers.accept_language);
        System.debug('url :: ' + res.url);
    }
}