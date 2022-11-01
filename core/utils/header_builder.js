const ConfigurationManager = require('../utils/configuration_manager');

module.exports.buildHeader = function(user) {
    let headers = ConfigurationManager.environment.users[user];
    headers = user === 'withoutTokenUser' ? {Authorization: ''} : headers;
    headers = user === 'invalidTokenUser' ? {Authorization: 'pk_123456789'} : headers;
    return headers;
}
