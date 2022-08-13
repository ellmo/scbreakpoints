//= require foundation

$(function(){
  $(document).foundation();

  attacker = null;
  target   = null;

  get_combatants();
});

parsed_url = function(){
  path   = "/api/parse"
  params = window.location.pathname;

  return(path + params);
}

get_combatants = function() {
  $.get(parsed_url(), function(data, _status){
    attacker = data.attacker;
    target   = data.target;
  })
}
