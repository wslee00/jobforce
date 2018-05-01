public class GlassdoorHttpMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        HttpResponse resp = new HttpResponse();
        StaticResource resource = [select Body from StaticResource where Name = 'glassdoorMockHtml'];
        resp.setBodyAsBlob(resource.Body);
        resp.setStatusCode(200);
        return resp;
    }
}