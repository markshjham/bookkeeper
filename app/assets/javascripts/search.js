document.addEventListener("turbolinks:load", function() { 
  var divClicks = document.getElementsByClassName("divClick");
  
  for (var i = 0; i < divClicks.length; i++) {
    divClicks[i].onclick = function() { event.target.children[0].focus(); };
  }
  
  var searchChoice = document.getElementById("search_choice");
  searchChoice.onchange = searchFunction;
  
  var searchDrop = document.getElementById("search-drop");
  searchDrop.onclick = function() {
    var searchBar = document.getElementById("search-bar");
    searchBar.classList.toggle("search-bar-active");
  };
  
});

function searchFunction() {
  
  var x = document.getElementById("search_choice");
  var range = document.getElementsByClassName("select_range");
  var week = document.getElementById("select_week");
  var last = document.getElementById("last_week");
  var month = document.getElementById("month_list");
  var month_check = document.getElementById("check_month");
  
  if (x.value === "") {
    range[0].style.display = "none";
    range[1].style.display = "none";
    month.style.display = "none";
    last.checked = false;
    month_check.checked = false;
  } 
  
  if (x.value === "date_range") {
    range[0].style.display = "block";
    range[1].style.display = "block";
    month.style.display = "none";
    last.checked = false;
    month_check.checked = false;
  }
  
  if (x.value === "last_week") {
    range[0].style.display = "none";
    range[1].style.display = "none";
    month.style.display = "none";
    last.checked = true;
    month_check.checked = false;
  }
  
  if (x.value === "view_month") {
    range[0].style.display = "none";
    range[1].style.display = "none";
    month.style.display = "block";
    last.checked = false;
    month_check.checked = true;
  }
};