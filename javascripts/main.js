$.urlParam = function(name, url) {
    if (!url) {
     url = window.location.href;
    }
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(url);
    if (!results) { 
        return undefined;
    }
    return results[1] || undefined;
}

$(document).ready(function () {
	var page = $.urlParam('page');
	if (page == undefined) {
		page = 'index';
	}
	page = '/bbslib/pages/bbslib/' + page + '.html';
	$('#main_content').headsmart();
	$( '#toc' ).load( '/bbslib/pages/bbslib/content.html');
	$( 'footer' ).load( '/bbslib/pages/bbslib/footer.html');
	$( 'article' ).load( page);
})

