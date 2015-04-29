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

function load_html(file_name, on_end_load) {
	$.ajax(
		{
			url: file_name,
			success: on_end_load
		}
	);
}

$(document).ready(
	function () {
		var page0 = $.urlParam('page');
		var page = '/bbslib/pages/bbslib/' + page0 + '.html';
		$('#main_content').headsmart();
		load_html(page,
				 function (result) {
					 $('article').html(result);
				 }
	 );
		load_html('/bbslib/pages/bbslib/content.html', 
				  function(result){
					  $('#toc').html(result);
					  $('#toc ul li a').each(function( index, element ) {
						  var lpage = $.urlParam('page', $( element ).attr('href'));
						  if (lpage == page0) {
							  var title = 'bbslib: ' + $(element).html();
							  $('#main_title').html(title);
							  document.title = title;
							  $(element).addClass('italic');
						  }
					  })
	  });
		load_html('/bbslib/pages/bbslib/footer.html',
				 function (result) {
					 $('footer').html(result);
				 }
	 );
	}
);


