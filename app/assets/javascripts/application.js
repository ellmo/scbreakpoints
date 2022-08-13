//= require foundation

$(function(){
  $(document).foundation();

  get_combatants();
});


function parsed_url(){
  path   = "/api/parse"
  params = window.location.pathname;

  return(path + params);
}

function get_combatants(){
  $.get(parsed_url(), function(data, _status){

    uncover("my", data.attacker);
    uncover("theirs", data.target);
  })
}

function uncover(side, id){
  $(`#${side}-content .tabs-panel`)
    .removeClass("is-active");
  $(`#${side}-tabs li`)
    .removeClass("is-active");

  content = $(`div#${side}-content a[data-unit-id=${id}]`)
    .addClass("selected")
    .closest(`.tabs-panel`)
    .addClass(`is-active`)
    .attr("id")

  $(`a#${content}-label`)
    .parent()
    .addClass("is-active");
}
