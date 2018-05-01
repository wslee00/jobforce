public with sharing class NewAccountController {
	@AuraEnabled
	public static Account importFromGlassdoor(String glassdoorUrl) {
		HttpRequest req = new HttpRequest();
		req.setMethod('GET');
		req.setEndpoint(glassdoorUrl);

		Http h = new Http();
		HttpResponse resp = h.send(req);
        
        String jsonString = resp.getBody().substringBetween('window.gdGlobals = window.gdGlobals ||', '}]') + '}';
        jsonString = jsonString.trim();
        jsonString = jsonString.right(jsonString.length() - 1);
        
        system.debug(logginglevel.error, '1: ' + jsonString);
        
        jsonString = removeBetween(jsonString, '\'test\' :', '},');
        
        system.debug(logginglevel.error, '2: ' + jsonString);
        
        jsonString = jsonString.replace('\'', '\"');
        
        system.debug(logginglevel.error, jsonString);
        
        Map<String, Object> globals = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
        System.debug(Logginglevel.error, 'globals: ' + globals);
        Account acc = new Account();
        Map<String, Object> employer = (Map<String, Object>) globals.get('employer');
        acc.Name = (String) employer.get('name');
        return acc;
        // System.debug(logginglevel.error, 'object: ' + JSON.deserializeUntyped(jsonString));
	}
    
    private static String removeBetween(String originalString, String open, String close) {
        Integer openIndex = originalString.indexOf(open);
        Integer closeIndex = originalString.indexOf(close, openIndex) + close.length();
        return originalString.left(openIndex) + originalString.right(originalString.length() - closeIndex);
    }
}