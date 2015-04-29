$.urlParam = function(name, url) {
	if (!url) {
		url = window.location.href;
	}
	var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(url);
	if (!results) { 
		return 'index';
	}
	return results[1] || 'index';
}

function load_page(page, on_end_load, place) {
	var file_name = '/bbslib/pages/bbslib/' + page + '.html';
	$.ajax(
		{
			url: file_name,
			success: function(result) {
				$(place).html(result);
				if (on_end_load) {
					on_end_load(result);
				}
			}
		}
	);
}

$(document).ready(
	function () {
		var page0 = $.urlParam('page');
		$('#main_content').headsmart();
		load_page(page0, null, 'article');
		load_page('content', 
				  function(result){
					  $('#toc a').each(function( index, element ) {
						  var lpage = $.urlParam('page', $( element ).attr('href'));
						  if (lpage == page0) {
							  var title = 'bbslib: ' + $(element).html();
							  $('#main_title').html(title);
							  document.title = title;
							  $(element).addClass('current-node');
						  }
					  })
		  }, '#toc');
		load_page('footer', null, 'footer');
	}
);


