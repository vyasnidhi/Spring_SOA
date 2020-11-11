public class ResponseWrapper {
    
    public class Args {
        public String foo1 {get;set;}
        public String foo2 {get;set;}
        
        public Args(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'foo1') {
                            foo1 = parser.getText();
                        } else if (text == 'foo2') {
                            foo2 = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Args consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Headers {
        public String x_forwarded_proto {get;set;} // in json: x-forwarded-proto
        public String x_forwarded_port {get;set;} // in json: x-forwarded-port
        public String host {get;set;}
        public String x_amzn_trace_id {get;set;} // in json: x-amzn-trace-id
        public String upgrade_insecure_requests {get;set;} // in json: upgrade-insecure-requests
        public String user_agent {get;set;} // in json: user-agent
        public String accept {get;set;}
        public String sec_fetch_site {get;set;} // in json: sec-fetch-site
        public String sec_fetch_mode {get;set;} // in json: sec-fetch-mode
        public String sec_fetch_user {get;set;} // in json: sec-fetch-user
        public String sec_fetch_dest {get;set;} // in json: sec-fetch-dest
        public String accept_encoding {get;set;} // in json: accept-encoding
        public String accept_language {get;set;} // in json: accept-language
        
        public Headers(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'x-forwarded-proto') {
                            x_forwarded_proto = parser.getText();
                        } else if (text == 'x-forwarded-port') {
                            x_forwarded_port = parser.getText();
                        } else if (text == 'host') {
                            host = parser.getText();
                        } else if (text == 'x-amzn-trace-id') {
                            x_amzn_trace_id = parser.getText();
                        } else if (text == 'upgrade-insecure-requests') {
                            upgrade_insecure_requests = parser.getText();
                        } else if (text == 'user-agent') {
                            user_agent = parser.getText();
                        } else if (text == 'accept') {
                            accept = parser.getText();
                        } else if (text == 'sec-fetch-site') {
                            sec_fetch_site = parser.getText();
                        } else if (text == 'sec-fetch-mode') {
                            sec_fetch_mode = parser.getText();
                        } else if (text == 'sec-fetch-user') {
                            sec_fetch_user = parser.getText();
                        } else if (text == 'sec-fetch-dest') {
                            sec_fetch_dest = parser.getText();
                        } else if (text == 'accept-encoding') {
                            accept_encoding = parser.getText();
                        } else if (text == 'accept-language') {
                            accept_language = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Headers consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public Args args {get;set;}
    public Headers headers {get;set;}
    public String url {get;set;}
    
    public ResponseWrapper(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'args') {
                        args = new Args(parser);
                    } else if (text == 'headers') {
                        headers = new Headers(parser);
                    } else if (text == 'url') {
                        url = parser.getText();
                    } else {
                        System.debug(LoggingLevel.WARN, 'ResponceWrapper consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static ResponseWrapper parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new ResponseWrapper(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT ||
                curr == System.JSONToken.START_ARRAY) {
                    depth++;
                } else if (curr == System.JSONToken.END_OBJECT ||
                           curr == System.JSONToken.END_ARRAY) {
                               depth--;
                           }
        } while (depth > 0 && parser.nextToken() != null);
    }
}