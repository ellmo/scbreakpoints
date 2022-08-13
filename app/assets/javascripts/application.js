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

    uncover_mine(data.attacker);
    uncover_theirs(data.target);
  })
}

function uncover_mine(id){
  $(`#my-content .tabs-panel`)
    .removeClass('is-active');
  $(`#my-tabs li`)
    .removeClass('is-active');

  race = $(`div#my-content a[data-unit-id=${id}]`)
    .addClass('selected')
    .closest(`.tabs-panel`)
    .addClass(`is-active`)
    .attr('id')

  $(`a#${race}-label`)
    .parent()
    .addClass('is-active');
}

function uncover_theirs(id){
  $(`#their-content .tabs-panel`)
    .removeClass('is-active');
  $(`#theirs-tabs li`)
    .removeClass('is-active');

  race = $(`div#theirs-content a[data-unit-id=${id}]`)
    .addClass('selected')
    .closest(`.tabs-panel`)
    .addClass(`is-active`)
    .attr('id')

  $(`a#${race}-label`)
    .parent()
    .addClass('is-active');
}
