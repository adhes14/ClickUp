const {setWorldConstructor, setDefaultTimeout} = require ("@cucumber/cucumber");
const configurationManager = require("../../core/utils/configuration_manager");

class CustomWorld {
    requestBody;
    response;
    team;
    space;
    folder;
    list;

    constructor({attach}){
        this.attach = attach;
    }
}

setDefaultTimeout(configurationManager.setUp.explicitTimeout);
setWorldConstructor(CustomWorld);
