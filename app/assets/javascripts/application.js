// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap 
//= require turbolinks
//= require charCount
//= require micropost
//=require private_pub
//=require autocomplete-rails
//= require_tree .

$( document ).ready(function() {
	$("#micropost_content").charCount({
			allowed: 140,		
			warning: 20,
			counterText: 'Characters left: '	
	});
});

$( document ).ready(function() {
	$("#reply_reply").charCount({
			allowed: 140,		
			warning: 20,
			counterText: 'Characters left: '	
	});
});
