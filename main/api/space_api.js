const RequestManager = require('../../core/api/RequestManager');

class SpaceApi {
    async create(teamId, endpoint, body){
        endpoint ? endpoint  : endpoint = `/team/${teamId}/space`;
        const response = await RequestManager.send('POST', endpoint, {}, body, 'owner');
        return response;
    }
    async delete(id){
        await RequestManager.send('DELETE', `/space/${id}`, {}, {}, 'owner');
    }
}

module.exports = new SpaceApi();
