//
//  DefaultData.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "DefaultData.h"
#import "dungeonMasterSingleton.h"

@implementation DefaultData



-(void)loadParserwithPath:(NSData*)path{
    _parser =[[NSXMLParser alloc]initWithData:path];
    _parser.delegate=self;
    [_parser setShouldProcessNamespaces:YES]; // We don't care about namespaces
    [_parser setShouldReportNamespacePrefixes:YES]; //
    [_parser setShouldResolveExternalEntities:YES]; // We just want data, no other stuff
 
  
}
-(void)AddNewRaces{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"NewRacesadded"] == true){
    Race * HalFELF=  [[dungeonMasterSingleton sharedInstance]createRace];
    HalFELF.name=@"Half-elf";
    HalFELF.playerRace = @true;
    HalFELF.fulltext= @"Half-elves are not truly an elf subrace, but they are often mistaken for elves. Half-elves usually inherit a good blend of their parents’ physical characteristics. Prefered Class Any. When determining whether a multiclass half-elf takes an experience point penalty, her highest-level class does not count.";
    Race * Hengeyokai=  [[dungeonMasterSingleton sharedInstance]createRace];
    Hengeyokai.name=@"Hengeyokai";
    Hengeyokai.playerRace = @true;
    Hengeyokai.fulltext= @"Hengeyokai in their true animal form look almost exactly like the animal form they're based on, although they're usually a bit larger in size. In their human form they look almost identical to the race they're disguised as, although they might possess a few traits typical of their animal form (for example, narrow eyes, slightly pointed nose and whisker like markings on the face for a fox hengeyokai). Their hybrid form tends to be an anthropomorphic animal with traits resembling that of their human form (fur color resembles human hair color, same general build, etc).";
    Race * Warforged=  [[dungeonMasterSingleton sharedInstance]createRace];
    Warforged.name=@"Warforged";
    Warforged.playerRace = @true;
    Warforged.fulltext= @"A mechinized race of warriors built for spefic taks. They do not sleep nor eat, but enter a state of inactivity for 4 hours to gain the benefits of an extended rest. While in this state, they are fully aware. Prefered class Any";
        
    
        
    Race * Tibbit=  [[dungeonMasterSingleton sharedInstance]createRace];
    Tibbit.name=@"Tibbit";
    Tibbit.playerRace = @true;
    Tibbit.fulltext= @"Tibbits (also known as catweres) are small, humanoid creatures that have the ability to turn into a common house cat. They arose from felines kept as familiars in ages past. The powerful magic that allows a familiar to gain intelligence and magic abilities slowly filtered from one generation of cats to the next. Whether tibbits evolved from a natural process, divine intervention, or a sudden surge in the magic running through their ancestry, none can say. Tibbits have never existed in large numbers, and their tendency to spread across the world leaves them with a fractured, incomplete racial history. Favored Class Rogue;";
        
        
        [[dungeonMasterSingleton sharedInstance]save];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"NewRacesadded"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}
-(void)AddRaces{
    Race * DragonBorn=  [[dungeonMasterSingleton sharedInstance]createRace];
    DragonBorn.name=@"Dragonborn";
    DragonBorn.playerRace = @true;
    DragonBorn.fulltext= @"Dragonborn are humanoid dragons. They are strong and wise with a deep culture and the blood of dragons still flowing through their veins. They can actually breath fire (or another type of element associated with their heritage) which can be useful in a pinch. Dragonborn are generally more suited to the Defender role (Fighter or Paladin), but can also make effective Leaders (Warlord) or even classes that use religious power (Avenger, Invoker).";
    
    Race * HalfORC=  [[dungeonMasterSingleton sharedInstance]createRace];
    HalfORC.name=@"Half-Orc";
    HalfORC.playerRace = @true;
    HalfORC.fulltext= @"Half-orcs are the offspring of humans and orcs and, though they tend to try and distinguish themselves more as humans than orc, they are often outcast because of their heritage. They are a strong hardy people, however, and very proud. They are best suited to the Striker role (Barbarian, Ranger, Rogue) but could also serve as an effective Defender role (Fighter, Warden) or perhaps even a Leader role (Warlord).";
    
    Race * Human=  [[dungeonMasterSingleton sharedInstance]createRace];
    Human.name=@"Human";
    Human.playerRace = @true;
    Human.fulltext= @"One of the best things about Humans is that they are very adaptable: they can be literally any class without much problem and succeed. Because of their adaptable nature, Humans start with lower base stats but more feats and skills than other races.";
    
    Race * Drawf=  [[dungeonMasterSingleton sharedInstance]createRace];
    Drawf.name=@"Dwarf";
    Drawf.playerRace = @true;
    Drawf.fulltext= @"Short, stout, strong and hardy. They’re best associated with either the Defender role (Fighter, Paladin) or the Leader role (Cleric, Warlord). It would also be fairly easy to see them conjuring their powers from the primal world (Wardens, Barbarians).";
    
    Race * Gnome=  [[dungeonMasterSingleton sharedInstance]createRace];
    Gnome.name=@"Gnome";
    Gnome.playerRace = @true;
    Gnome.fulltext= @"Gnomes are a tricky race, full of tiny beings (even smaller than Halflings) that like to be tricksters. They come from the Feywild, the same dimension the Eladrin come from, and thus are innately magic. They are often very curious and funny beings that rely more on stealth and deception than brute strength. They are best suited for Striker roles (Rogue, Warlock, Sorcerer), though can be effective in Controller roles (Wizard, Druid) and Leader roles (Bard).";
    
    Race * Eladrin=  [[dungeonMasterSingleton sharedInstance]createRace];
    Eladrin.name=@"Eladrin";
    Eladrin.playerRace = @true;
    Eladrin.fulltext= @"The Eladrin are elves that have directly descended from the Feywild (an alternate dimension to the mortal realm) and are creatures of magic. They can actually teleport about the battlefield, but are lithe and perhaps not best-suited for melee combat. Think the elves of Rivendell from Lord of the Rings. Recommended classes would be Controller roles (Wizard, Invoker), Striker roles (Ranger, Rogue) or even Leader roles (Warlord, Bard).";
    
    Race * HighELF=  [[dungeonMasterSingleton sharedInstance]createRace];
    HighELF.name=@"Elf";
    HighELF.playerRace = @true;
    HighELF.fulltext= @"They are wood elves, having lived in the woods and the wilds all their lives. They are naturally talented with bows and are nimble beings but are not as magical as their Eladrin brethren. Appropriate classes would be the Striker roles (Rogue, Ranger), the Leader role (Warlord, Shaman) or the Controller role (Druid).";


    
    Race * Halfling=  [[dungeonMasterSingleton sharedInstance]createRace];
    Halfling.name=@"Halfling";
    Halfling.playerRace = @true;
    Halfling.fulltext= @"Instead of being stout and plucky, they’re agile and nimble little guys who seem to be extra lucky. Appropriate classes would be the Striker roles (Rogue, Ranger) or the Leader role (Bard, Warlord).";
    
    Race * Tieflings=  [[dungeonMasterSingleton sharedInstance]createRace];
    Tieflings.name=@"Tiefling";
    Tieflings.playerRace = @true;
    Tieflings.fulltext= @"Tieflings come from an ancient line of humans who made a deal with demons to receive more power. The Tiefling empire actually ruled over much of the stock 4E world and I’ve utilized some of that in my own custom worlds. Though their blood has been a bit watered down over the years, they do still have demonic characteristics (horns, colored skin, tail) and can still conjure some of that infernal power they used to be known for. They are best associated with the Striker role (Warlock, Rogue, Sorcerer, Avenger), though the Leader role can work (Warlord, Bard) or even a Controller role (Wizard, Invoker).";
    
    Race * Goliath =  [[dungeonMasterSingleton sharedInstance]createRace];
    Goliath.name=@"Goliath";
    Goliath.playerRace = @true;
    Goliath.fulltext=@"Goliaths are big mountain-dwelling nomads who may or may not be a descendant of giants. They live in tribes, commune with nature and train for physical strength, all because they see life as a grand competition. They are best suited for the Defender roles (Fighter, Warden), but could also be effective in a Striker role (Barbarian, Ranger), select Controller roles (Druid) or even a Leader role (Shaman, Warlord).";

    
    Race * Shifter  =  [[dungeonMasterSingleton sharedInstance]createRace];
    Shifter.name=@"Shifter";
    Shifter.playerRace = @true;
    Shifter.fulltext=@"Shifters are humans with animalistic features. Possibly descendant from lycanthropes, every Shifter can generally be identified by their animal-like eyes, long teeth, sharp claws and strong muscles. Usually resembling either feline or canine creatures, Shifters are quick and fierce hunters that are very in-tune with the primal world. They can be best suited either in a Striker role (Ranger, Barbarian) or in a Defender role (Fighter, Warden), though could very easily fit in select Controller (Druid) or Leader (Shaman) roles.";

    
    [[dungeonMasterSingleton sharedInstance]save];
    
    
}
-(void)addNPCMaster{
    [[dungeonMasterSingleton sharedInstance]createNPCOwner];

}

-(void)createDefaultData{
  
        NSString *path = [[NSBundle mainBundle] pathForResource:@"feat" ofType:@"xml"];
        [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
        self.currentFeat= [[dungeonMasterSingleton sharedInstance]createFeat];
        if(_parser)
            [_parser parse];
        self.currentProperty= [[NSMutableString alloc]init];
    
   
    
}

-(void)createDefaultSpells{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"spell" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentSpell= [[dungeonMasterSingleton sharedInstance]createSpell];
        if(_parser)
    [_parser parse];
    [self clearCurrentProperty];
}

-(void)createDefaultItems{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"item" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentItem= [[dungeonMasterSingleton sharedInstance]createItems];
        if(_parser)
    [_parser parse];
    [self clearCurrentProperty];
}


-(void)createDefaultEquipment{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"equipment" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentEquipment= [[dungeonMasterSingleton sharedInstance]createItems];
    if(_parser)
    [_parser parse];
    [self clearCurrentProperty];
}


-(void)createDefaultMonster{
 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"monster" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentMonster= [[dungeonMasterSingleton sharedInstance]createMonster];
    self.currentRace = [[dungeonMasterSingleton sharedInstance]createRace];

       if(_parser)
    [_parser parse];
    [self clearCurrentProperty];
}

-(void)createDefaultPower{
    [_parser abortParsing];
    _parser.delegate=nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"power" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentPowers= [[dungeonMasterSingleton sharedInstance]createPower];
       if(_parser)
    [_parser parse];
    [self clearCurrentProperty];
}

-(void)createDefaultSkill{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"skill" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentSkill= [[dungeonMasterSingleton sharedInstance]createSkill];
       if(_parser)
    [_parser parse];
    [self clearCurrentProperty];
}

-(void)createDefaultDomain{
 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"domain" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentDomain= [[dungeonMasterSingleton sharedInstance]createDomain];
        if(_parser)
    [_parser parse];
    [self clearCurrentProperty];
}


-(void)createDefaultCharacterClass{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"class" ofType:@"xml"];
    [self loadParserwithPath:[NSData dataWithContentsOfFile:path]];
    self.currentCharacterClass= [[dungeonMasterSingleton sharedInstance]createCharacterClass];
    if(_parser)
        [_parser parse];
    [self clearCurrentProperty];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentProperty) {
        [self.currentProperty appendString:string];
    }
}


-(void)clearCurrentProperty{
      self.currentProperty= [NSMutableString stringWithString:@""];
}

-(void)appendHTMLTag:(NSString *)tagName isOpeningTag:(BOOL)openingTag withAttributes:(NSDictionary*)attributeDict{
    
    if([tagName isEqualToString:@"div"] || [tagName isEqualToString:@"b"] || [tagName isEqualToString:@"i"] || [tagName isEqualToString:@"ul"] ||[tagName isEqualToString:@"li"]   || [tagName isEqualToString:@"br"] ||[tagName isEqualToString:@"p"]  || [tagName isEqualToString:@"table"] ||[tagName isEqualToString:@"tr"]  || [tagName isEqualToString:@"td"] ||[tagName isEqualToString:@"h4"] ){
        
        if(openingTag){
             [self.currentProperty appendString:[NSString stringWithFormat:@"<%@ ",tagName]];
            for (NSString *attributeName in [attributeDict allKeys]) {
                NSString *attributeValue = [attributeDict objectForKey:attributeName];
              [self.currentProperty appendString:[NSString stringWithFormat:@"%@='%@' ",attributeName,attributeValue ]];
            }
            [self.currentProperty appendString:@">"];
           
        }
        else{
            [self.currentProperty appendString:[NSString stringWithFormat:@"</%@>",tagName]];

        }
    }

}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    [self appendHTMLTag:elementName isOpeningTag:YES withAttributes:attributeDict];
    
    if(self.currentFeat){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }

    }else if(self.currentSpell){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }
        
        if ([elementName isEqualToString:@"school"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"subschool"]){
            [self clearCurrentProperty];
        }
    }else if(self.currentPowers){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }
        
        if ([elementName isEqualToString:@"discipline"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"subdiscipline"]){
            [self clearCurrentProperty];
        }
    }else if(self.currentItem){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }
        
        if ([elementName isEqualToString:@"category"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"subcategory"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"weight"]){
            [self clearCurrentProperty];
        }
    }else if(self.currentEquipment){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }
        
        if ([elementName isEqualToString:@"family"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"category"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"weight"]){
            [self clearCurrentProperty];
        }
    }else if(self.currentMonster){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }
    }else if (self.currentDomain){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }

    }else if (self.currentSkill){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"key_ability"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"subtype"]){
            [self clearCurrentProperty];
        }
        
    }else if (self.currentCharacterClass){
        if ([elementName isEqualToString:@"name"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"type"]){
            [self clearCurrentProperty];
        }if ([elementName isEqualToString:@"class_skills"]){
            [self clearCurrentProperty];
        }
    }

    

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
     [self appendHTMLTag:elementName isOpeningTag:NO withAttributes:nil];
    if(self.currentFeat){
        if ([elementName isEqualToString:@"name"]){
            self.currentFeat.name= self.currentProperty;
            
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentFeat.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentFeat= [[dungeonMasterSingleton sharedInstance]createFeat];
        }
       
    }else if(self.currentSpell){
        if ([elementName isEqualToString:@"name"]){
            self.currentSpell.name= self.currentProperty;
          
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentSpell.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentSpell= [[dungeonMasterSingleton sharedInstance]createSpell];
        }
        
        if ([elementName isEqualToString:@"school"]){
             self.currentSpell.school= self.currentProperty;
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"subschool"]){
            self.currentSpell.subschool= self.currentProperty;
            [self clearCurrentProperty];
        }

    }else if(self.currentPowers){
        if ([elementName isEqualToString:@"name"]){
            self.currentPowers.name= self.currentProperty;
           
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentPowers.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentPowers= [[dungeonMasterSingleton sharedInstance]createPower];
        }
        
        if ([elementName isEqualToString:@"discipline"]){
            self.currentPowers.discipline= self.currentProperty;
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"subdiscipline"]){
            self.currentPowers.subDiscipline= self.currentProperty;
            [self clearCurrentProperty];
        }
        
    }else if(self.currentItem){
        if ([elementName isEqualToString:@"name"]){
            self.currentItem.name= self.currentProperty;
            
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentItem.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentItem= [[dungeonMasterSingleton sharedInstance]createItems];
        }
        
        if ([elementName isEqualToString:@"category"]){
            self.currentItem.type= self.currentProperty;
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"subcategory"]){
            self.currentItem.subtype= self.currentProperty;
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"weight"]){
            self.currentItem.weight= self.currentProperty;
            [self clearCurrentProperty];
        }
        
    }
    else if(self.currentEquipment){
        if ([elementName isEqualToString:@"name"]){
            self.currentEquipment.name= self.currentProperty;
                      [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentEquipment.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentEquipment= [[dungeonMasterSingleton sharedInstance]createItems];
        }
        
        if ([elementName isEqualToString:@"family"]){
            self.currentEquipment.type= self.currentProperty;
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"category"]){
            self.currentEquipment.subtype= self.currentProperty;
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"weight"]){
            self.currentEquipment.weight= self.currentProperty;
            [self clearCurrentProperty];
        }
        
    }else if(self.currentMonster){
        if ([elementName isEqualToString:@"name"]){
            self.currentMonster.name= self.currentProperty;
            self.currentRace.name= self.currentProperty;
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentMonster.fulltext= self.currentProperty;
            self.currentRace.fulltext= self.currentProperty;
            self.currentRace.playerRace= @false;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentMonster= [[dungeonMasterSingleton sharedInstance]createMonster];
            self.currentRace= [[dungeonMasterSingleton sharedInstance]createRace];
        }
    }else if (self.currentDomain){
        if ([elementName isEqualToString:@"name"]){
            self.currentDomain.name= self.currentProperty;
            
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentDomain.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentDomain= [[dungeonMasterSingleton sharedInstance]createDomain];
        }           
    }else if (self.currentSkill){
        if ([elementName isEqualToString:@"name"]){
            self.currentSkill.name= self.currentProperty;
            
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentSkill.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentSkill= [[dungeonMasterSingleton sharedInstance]createSkill];
        }
        if ([elementName isEqualToString:@"subtype"]){
            self.currentSkill.type= self.currentProperty;
            [self clearCurrentProperty];
            
        }
        if ([elementName isEqualToString:@"key_ability"]){
            self.currentSkill.keyAbility= self.currentProperty;
            [self clearCurrentProperty];
           
        }
    }else if (self.currentCharacterClass){
        if ([elementName isEqualToString:@"name"]){
            self.currentCharacterClass.name= self.currentProperty;
            
            [self clearCurrentProperty];
        }
        if ([elementName isEqualToString:@"full_text"]){
            self.currentCharacterClass.fulltext= self.currentProperty;
            [self clearCurrentProperty];
            [[dungeonMasterSingleton sharedInstance]save];
            self.currentCharacterClass= [[dungeonMasterSingleton sharedInstance]createCharacterClass];
        }
        if ([elementName isEqualToString:@"type"]){
            self.currentCharacterClass.type= self.currentProperty;
            [self clearCurrentProperty];
        }if ([elementName isEqualToString:@"class_skills"]){
            NSArray *skills= [self.currentProperty componentsSeparatedByString:@","];
            int i=0;
            for (NSString * skillNamed in skills){
                NSString * realSkillNamed;
                if(i > 0){
                realSkillNamed= [skillNamed stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
              
                }else{
                    realSkillNamed=skillNamed;
                  i++;
                }
               Skills * curSkill= [[dungeonMasterSingleton sharedInstance]findSkillNamed:realSkillNamed];
                if(curSkill){
                    [self.currentCharacterClass addClassSkillsObject:curSkill];
                    [curSkill addClassSkillsObject:self.currentCharacterClass];
                    [[dungeonMasterSingleton sharedInstance]save];
                }
            }
            [self clearCurrentProperty];
        }
     
    }

}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    if(self.currentFeat){
            [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentFeat];
            self.currentFeat=nil;
            [self createDefaultSpells];
        
        
    }else if(self.currentSpell){
                    [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentSpell];
            self.currentSpell=nil;
            [self createDefaultPower];
        
    }else if(self.currentPowers){
       
            [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentPowers];
            self.currentPowers=nil;
            [self createDefaultItems];
        
    }else if(self.currentItem){
            [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentItem];
            self.currentItem=nil;
            [self createDefaultEquipment];
        
    }
    else if(self.currentEquipment){
            [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentEquipment];
            self.currentEquipment=nil;
            [self createDefaultMonster];
        
    }else if(self.currentMonster){
            [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentMonster];
            self.currentMonster=nil;
            [self createDefaultDomain];
        
    }else if (self.currentDomain){
            [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentDomain];
            self.currentDomain=nil;
            [self createDefaultSkill];
    }else if (self.currentSkill){
        [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentSkill];
        self.currentSkill=nil;
        [self createDefaultCharacterClass];

    }else if (self.currentCharacterClass){
        [[dungeonMasterSingleton sharedInstance]deleteItem:self.currentCharacterClass];
        self.currentCharacterClass=nil;
        [self AddRaces];
        [self addNPCMaster];
    }
     [[dungeonMasterSingleton sharedInstance]save];
    [parser abortParsing];
    parser.delegate=nil;
}

@end


