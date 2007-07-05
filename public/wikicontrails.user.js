// ==UserScript==
// @name          Wiki Contrails
// @namespace     http://wikicontrails.gandrew.com
// @description   Records travels through wikipedia
// @include       http://en.wikipedia.org/wiki/*
// @exclude       http://en.wikipedia.org/wiki/Special*
// ==/UserScript==

webService= "http://wikicontrails.gandrew.com/visit/create"

xhr = GM_xmlhttpRequest({
    method: 'post',
    url: webService,
    headers: {'Content-type': 'application/x-www-form-urlencoded'},
    data: encodeURI("auth=http&wiki_page[url]=" +  location.href),
    onload: onload,
    onerror: onerror
});


function onload(xhr){
    
}

function onerror(xhr){
    alert("Failure in saving contrail");
}