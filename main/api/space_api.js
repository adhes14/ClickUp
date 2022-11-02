const RequestManager = require('../../core/api/RequestManager');
const ConfigurationManager = require('../../core/utils/configuration_manager');

class SpaceApi {
    async create(teamId, endpoint, body){
        endpoint ? endpoint  : endpoint = `/team/${teamId}/space`;
        const header = ConfigurationManager.environment.users['owner'];
        const response = await RequestManager.send('POST', endpoint, {}, body, header);
        return response;
    }
    async delete(id){
        const header = ConfigurationManager.environment.users['owner'];
        await RequestManager.send('DELETE', `/space/${id}`, {}, {}, header);
    }
}

module.exports = new SpaceApi();
