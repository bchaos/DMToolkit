YUI().use 'node-base', 'node-event-delegate', (Y) ->
    Y.one('body').delegate('click', (e)->                               
            e.preventDefault();
        , 'a[href="#"]');
    menuButton = Y.one '.nav-menu-button'
    nav = Y.one('#nav');
    menuButton.on 'click', (e) ->
        nav.toggleClass 'active'
      
     
