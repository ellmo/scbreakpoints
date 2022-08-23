//= require foundation

$(function(){
  updateState();
  setup();
});

function setup(){
  $(document).foundation();

  $.get(parsed_url(), function(data, _status){
    fix_links("my", data.target);
    fix_links("theirs", data.attacker);
    prevent_link_defaults();
    uncover("my", data.attacker);
    uncover("theirs", data.target);
  })
}

function updateState(html=null, path=null){
  html = html || document.documentElement.innerHTML;
  path = path || window.location.pathname

  window.history.pushState({ "html": html }, "", path);
}

function replacePage(html){
  document.documentElement.innerHTML = html;
}


function parsed_url(){
  path   = "/api/parse"
  params = window.location.pathname;

  return(path + params);
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

function prevent_link_defaults(){
  $(`a[data-unit-name]`).on("click", unit_clicked)
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

function unit_clicked(event){
  event.preventDefault();
  href = $(event.currentTarget).attr("href")

  $.get(href, function(html, _status, _response){
    updateState(html, href);
    replacePage(html);
    setup();
  })
}

window.onpopstate = function(event){
  if(event.state && event.state.html){
    replacePage(event.state.html)
    setup();
  }
};
