const {Given, When, Then} = require('@cucumber/cucumber');
const fetch = (...args) => import('node-fetch').then(({default: fetch}) => fetch(...args));
const {JSONPath} = require('jsonpath-plus');
const assert = require('assert');

let theUrl = null;
let theResponse = null;
let theResponseData = null;
let theRequestData = null;


Given('a request url {string}', async function (aUrl) {
    theUrl = aUrl;
});

When('the request sends GET', async function () {
    theResponse = await fetch(theUrl);
    theResponseData = await theResponse.json();
});

Then('the response status is {int}', function (expected) {
    assert.strictEqual(theResponse.status, expected);
});

Then(/^the response json at \$(.*?) contains "(.*?)"$/, async (jsPath, theText) => {
    assert.strictEqual(JSONPath({path: '$' + jsPath, json: theResponseData}).toString(), theText);
});

Given(/^a request json payload$/, function (jsonPayload) {
    theRequestData = jsonPayload;
});

async function postTheRequestData() {
    theResponse = await fetch(theUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: theRequestData,
    });
    theResponseData = await theResponse.json();
}

When(/^the request sends POST$/, async function () {
    await postTheRequestData();
});

Then(/^the response json at \\\$\\\.\\\._id is a hexadecimal number$/, function () {
    let theIdStr = JSONPath({path: '$.._id', json: theResponseData}).toString();
    // Check whether the string for id contains 1 or more only hexadecimal digits
    assert.ok(/^[0-9a-fA-F]+$/.test(theIdStr));
});

async function deleteTheData() {
    theResponse = await fetch(theUrl, {
        method: 'DELETE',
    });
    theResponseData = await theResponse.json();
}

When(/^the request sends DELETE$/, async function () {
    await deleteTheData();
});

Then(/^the response json at \$\.listPersons is false$/, function () {
    assert.ok(!JSONPath({path: '$.listPersons', json: theResponseData}).toString());
});

Given(/^the following persons are known$/, async function (datatable) {
    // First we clean up the data in the database
    await deleteTheData();
    // Subsequently we POST the data from the scenario to the database
    const theKeys = datatable.rawTable[0];
    for (let i = 1; i < datatable.rawTable.length; i++) {
        let obj = {};
        // Forming key-value pairs in an object
        for (let j = 0; j < theKeys.length; j++) {
            obj[theKeys[j]] = datatable.rawTable[i][j];
        }
        // Serialize object to JSON and POST it
        theRequestData = JSON.stringify(obj);
        await postTheRequestData();
    }
});
