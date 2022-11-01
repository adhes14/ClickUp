const RequestManager = require('../../core/api/RequestManager');
const { buildHeader } = require('../../core/utils/header_builder');

class SpaceApi {
    async create(teamId, endpoint, body){
        endpoint ? endpoint  : endpoint = `/team/${teamId}/space`;
        const response = await RequestManager.send('POST', endpoint, {}, body, buildHeader('owner'));
        return response;
    }
    async delete(id){
        await RequestManager.send('DELETE', `/space/${id}`, {}, {}, buildHeader('owner'));
    }
}

module.exports = new SpaceApi();
