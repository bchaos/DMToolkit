YUI().use 'node-base', 'node-event-delegate', 'app-base', 'app-transitions','handelbars','menuplugin', (Y) ->

    
    pageApp = new Y.App {
                    views: 
                        home : {preserve: true},
                        campaigns: {parent: 'home'},
                        players: {parent: 'home'},
                        npcs: {parent: 'home'},
                        encounters: {parent: 'home'},
                        notes: {parent: 'home'},
                        external: {parent: 'home'},
                        about: {parent: 'home'},
                    transitions: 
                        true
                    container:
                        '#pageContent'
                    serverRouting:
                        false
    }
    
    pageApp.route '*', ->
       
        
    pageApp.route '#/Campaigns', ->
        Y.one('hero').set('text', 'Example App - Home');
        
    Y.menuplugin.render();
    pageApp.render().dispatch();