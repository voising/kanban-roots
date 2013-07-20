//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require jscolor/jscolor
//= require twitter/bootstrap
//= require_self
//= require_tree .

$(function() {
    $('#project_contributor_tokens').tokenInput('/contributors.json', {
        prePopulate: $('project_contributor_tokens').data('pre'),
        preventDuplicates: true,
        hintText: 'Type in a contributor name or username',
        noResultsText: 'No contributors',
        theme: 'facebook'
    });

    $('.close').on('click', function(){
       $(this).parent().fadeOut('fast');
    });

    $('.tt').tooltip({placement:'right'});
    $('.dropdown-toggle').dropdown();
    //$(".collapse").collapse();


    /*** NAVBAR ***/

    if (document.location.href.indexOf('board') != -1) {
        var allowNavBarToMoveAway = true;
        $('.navbar-inner').hover(function(){
            allowNavBarToMoveAway = false;
            $(this).stop().animate({marginTop: '0'});
        }, function(){
            allowNavBarToMoveAway = true;
            that = $(this);
            setTimeout(function(){
                if (allowNavBarToMoveAway) {
                    that.stop().animate({marginTop: '-35px'});
                }
            }, 2000);
        });

        setTimeout(function(){
            $('.navbar-inner').animate({marginTop: '-35px'});
        }, 2000);
    }
});

