YUI.add('menuplugin', (Y) ->
    menuDisplay=null
    menuTemplateSource =null
    menuTemplate = null
    menuLink =Y.one('#menuLink');
    rollLink =Y.one('#rollLink');
    setupMenu=->
        menuDisplay = menu :[
            {
                title:'Campaigns',
                image:'images/103-map-white.png',
                quantity:'0'
            },
            {
                title:'Players',
                image:'images/111-user.png',
                quantity:'10'
            },
            {
                title:'NPCs',
                image:'images/111-user.png',
                quantity:'9'
            },
            {
                title:'Encounters',
                image:'images/251-sword-white.png',
                quantity:'11'
            },
            {
                title:'Notes',
                image:'images/179-notepad-white.png',
                quantity:'10'
            },
            {
                title:'Compendium',
                image:'images/33-cabinet-white.png',
                quantity:'8'
            },
            {
                title:'External',
                image:'images/180-stickynote-white.png',
                quantity:'8'
            },
            {
                title:'Roll Dice',
                image:'images/130-dice-white.png',
                quantity:[]
            },
            {
                title:'About',
                image:'images/42-info.png',
                quantity:[]
            }
        ]
        menuTemplateSource = Y.one('#menu-template').getHTML()
        menuTemplate = Y.Handlebars.compile menuTemplateSource
        
    menuAnim =  Y.one('#menu').plug Y.Plugin.NodeFX, {
        from: { left: 0 },
        to: 
            left :250
        easing:Y.Easing.easeOut,
        duration:0.5
    }
    menuLinkAnim =  Y.one('#menuLink').plug Y.Plugin.NodeFX, {
        from: { left: 0 },
        to: 
            left :250
        easing:Y.Easing.easeOut,
        duration:0.5
    }
    rollLinkAnim =  Y.one('#rollLink').plug Y.Plugin.NodeFX, {
        from: { left: 0 },
        to: 
            left :250
        easing:Y.Easing.easeOut,
        duration:0.5
    }  
    
    toggleMenus=(e)->
        rollLinkAnim.fx.run();
        menuLinkAnim.fx.run();
        menuLinkAnim.fx.set('reverse', !menuAnim.fx.get('reverse')); 
        rollLinkAnim.fx.set('reverse', !menuAnim.fx.get('reverse')); 

        
    startSideMenu=(e)->
        menuAnim.fx.run();
        menuAnim.fx.set('reverse', !menuAnim.fx.get('reverse'));
        
        
    toggleSideMenu = (e)->
        toggleMenus e
        startSideMenu e
        
        
        
    
    toggleRollMenu =(e) ->
        
        
    bindPhoneMenu = ->
        menuLink.on 'click' , toggleSideMenu
        rollLink.on 'click' , toggleRollMenu
            
    
    Y.menuplugin=  
        render :()->
            setupMenu()
            html= menuTemplate menuDisplay
            Y.one('#menu').setHTML html
            bindPhoneMenu()
            

,'0.1.1'
,requires: 
	['handlebars-base','handelbars-comiler', 'handlebars','node', 'anim']
);