@isTest
private class TestNewAccountController {
	@isTest
    static void testImportGlassdoor() {
        Test.setMock(HttpCalloutMock.class, new GlassdoorHttpMock());
        Test.startTest();
        Account acc = NewAccountController.importFromGlassdoor('https://www.glassdoor.com');
        Test.stopTest();
        System.assertEquals('Salesforce', acc.Name);
    }
}