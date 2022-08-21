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

    fix_links("my", data.target);
    fix_links("theirs", data.attacker);
    uncover("my", data.attacker);
    uncover("theirs", data.target);
  })
}

function fix_links(side, unitName){
  path = window.location.pathname;

  switch(side){
    case "my":
      $(`#${side}-content a[data-unit-name]`)
        .each(function(){
          $(this).attr("href", $(this).attr("href").replace(/(\w*)/, `/$1:${unitName}`))
        })
      break;
    case "theirs":
      $(`#${side}-content a[data-unit-name]`)
        .each(function(){
          $(this).attr("href", $(this).attr("href").replace(/(\w*)/, `/${unitName}:$1`))
        })
      break;
    default:
      null;
  }
}

function uncover(side, unitName){
  $(`#${side}-content .tabs-panel`)
    .removeClass("is-active");
  $(`#${side}-tabs li`)
    .removeClass("is-active");

  content = $(`div#${side}-content a[data-unit-name=${unitName}]`)
    .addClass("selected")
    .closest(".tabs-panel")
    .addClass("is-active")
    .attr("id")

  $(`a#${content}-label`)
    .parent()
    .addClass("is-active");
}
