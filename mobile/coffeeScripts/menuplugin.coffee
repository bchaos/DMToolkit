YUI.add('menuplugin', (Y) ->
    menuDisplay=null
    menuTemplateSource =null
    menuTemplate = null
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
        
    Y.menuplugin=  
        render :()->
            setupMenu()
            html= menuTemplate menuDisplay
            Y.one('#menu').setHTML html

,'0.1.1'
,requires: 
	['handlebars-base','handelbars-comiler', 'handlebars','node']
);