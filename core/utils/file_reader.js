const fs = require("fs");

module.exports.readJson = function (filePath) {
    if (!fs.existsSync(filePath)) {
        throw Error("Invalid path value");
    }
    const rawdata = fs.readFileSync(filePath);
    return JSON.parse(rawdata);
}