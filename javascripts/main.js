$.urlParam = function(name, url) {
	if (!url) {
		url = window.location.href;
	}
	var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(url);
	if (!results) { 
		return 'index';
	} else {
		return results[1] || 'index';
	}
}

function load_page(page, place, on_end_load) {
	var file_name = '/bbslib/pages/bbslib/' + page + '.html';
	$.ajax(
		{
			url: file_name,
			success: function(result) {
				$(place).html(result, place);
				if (on_end_load) {
					on_end_load(result, place);
				}
			}
		}
	);
}

$(document).ready(
	function () {
		var page0 = $.urlParam('page');
		load_page(page0, 'article');
		load_page('content', 'menu', 
				  function(result, place){
					  $(place + ' a').each(function( index, element ) {
						  var lpage = $.urlParam('page', $( element ).attr('href'));
						  if (lpage == page0) {
							  var title = 'bbslib: ' + $(element).html();
							  $('#main_title').html(title);
							  document.title = title;
							  $(element).addClass('current-node');
							  return false;
						  }
					  })
		  });
		load_page('footer', 'footer');
	}
);


