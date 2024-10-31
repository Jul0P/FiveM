$(document).ready(function(){ 
	function ShowCinema() {
	  $("html").css("display", "block");
	}
	function CloseCinema() {
	  $("html").css("display", "none");
	}
	window.addEventListener('message', function(event){
	  var item = event.data;
	  if(item.openCinema == true) {
			ShowCinema();
		}
	  if(item.openCinema == false) {
			CloseCinema();
	  }
	});
});