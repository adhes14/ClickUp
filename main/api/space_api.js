const RequestManager = require('../../core/api/RequestManager');

class SpaceApi {
    async create(verb, endpoint, body, user){
        verb ? verb  : verb = 'POST';
        endpoint ? endpoint  : endpoint = '/team/31589386/space';
        user ? user  : user = 'owner';
        const response = await RequestManager.send(verb, endpoint, {}, body, user);
        return response;
    }
    async delete(id){
        await RequestManager.send('DELETE', `/space/${id}`, {}, {}, 'owner');
    }
}

module.exports = new SpaceApi();
