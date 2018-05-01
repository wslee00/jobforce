({
    doInit : function(component, event, helper) {

    },
    importGlassdoorAttrs : function(component, event, helper) {
        var glassdoorUrl = component.find("glassdoorUrl").get("v.value");
        console.log('glassdoorUrl: ' + glassdoorUrl);
        var importAction = component.get("c.importFromGlassdoor");
        importAction.setParams({ "glassdoorUrl": glassdoorUrl });
        importAction.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var account = response.getReturnValue();
                console.log(account.Name);
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(importAction);
    }
})