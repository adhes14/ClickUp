const RequestManager = require('../../core/api/RequestManager');

class FolderApi {
    async create(spaceId, body){
        const response = await RequestManager.send('POST', `/space/${spaceId}/folder`, {}, body, 'owner');
        return response;
    }
    async delete(id){
        await RequestManager.send('DELETE', `/folder/${id}`, {}, {}, 'owner');
    }
}

module.exports = new FolderApi();
