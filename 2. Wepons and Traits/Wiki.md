{{BackToTutorials}}

This page is a tutorial on how to create a rimworld mod it will step you through the process of creating a mod from scratch. from basic files structure to writing code for your mod. This tutorial is aimed at people who have never created a mod before and are looking to get started. and is meant to be a updated guide to the old tutorials on the wiki.

This is a follow up to my [[Modding_Tutorials/Geting_started_with_mods|previous tutorial]] on how to make a mod. if you have not:
# Set up a mod folder structure
# Created an About.xml file
# Added a new item to the game
# Tested the mod in game using the Debug menu

Then you should go back a read the [[Modding_Tutorials/Geting_started_with_mods|previous tutorial]].

=Goal of this tutorial=
By the end of this tutorial you will have:
# Created a weapon with custom stats
# Learned how to add sounds to your mod
# Learned how to add a new trait to the game
# Learned how to create a new research project
# Learned how to create a new recipe
lets get started.

=Mod template=
[https://github.com/Burgess12/Rimwold-Dotnet-Template Rimworld dotnet template] is a mod template that can be used to quickly set up a mod. as by now you should have a basic understanding of how mods work it is recommended to use the template to save time. If you want to do things manually thats fine (Your life).

=Visual Studio Code Snippets=
In order to make modding easier I have created a set of code snippets for Visual Studio Code. These snippets will help you create the Xml structure for your mod. To use these snippets open VsCode then:
<pre>
File -> Preferences -> Configure User Snippets -> XML
</pre>
this will open a file called xml.json. copy [https://raw.githubusercontent.com/Burgess12/RimWorld-Mod-Tutorials/master/2.%20Wepons%20and%20Traits/CodeSnippets.json this code] and paste it into the xml.json file. save the file and you are ready to go.

This will allow you to type "rwweapon" to generate the skeleton for a new weapon. you can then fill in the details for your weapon.

=Creating a new weapon=
The first thing we are going to do is create a new weapon. 
==Creating the xml file==
Start by creating a new file in the Defs folder called "ThingDefs_Weapons.xml". this is where we will put the xml for our new weapon. </br>
Start by adding the Xml header to the file.
<pre>
<?xml version="1.0" encoding="utf-8" ?>
</pre>
 If using VsCode simply type "rwxml" and press tab to generate the header. </br>

 ==Making a bullet def==
 Before we can make a weapon there needs to be a bullet that the weapon can fire.
<pre>
<Defs>
    <ThingDef ParentName="BaseBullet">
        <defName>MM_Bullet</defName>
        <label>Tutorial Bullet</label>
        <graphicData>
            <texPath>Things/Projectile/Bullet_Small</texPath> 
            <!-- unlike the other tutorials, we are using a pre-existing texture that is already in the game. -->  
            <graphicClass>Graphic_Single</graphicClass>
            <drawSize>1.1</drawSize> <!-- bigger the number, bigger the bullet -->
        </graphicData>
        <projectile>
            <!-- Now we define the projectiles damage. -->
            <damageDef>Bullet</damageDef>
            <damageAmountBase>10</damageAmountBase>
            <stoppingPower>1</stoppingPower>
            <speed>44</speed>
        </projectile>
    </ThingDef>
</Defs>
</pre> 
</br>
If you added the code snippets you can save time by typing "rwbullet" and pressing tab. this will generate the skeleton for the bullet, you can then fill in the details (pushing tab will move you to the next field). </br>

==Making a weapon def==
'''''Note: ''''' The weapon def is long and extremely picky with spelling, formatting and capitalization. if you have not added the code snippets I recommend you add them now. </br>

Awesome we now have a bullet but we need a weapon to fire it. for now lets uses sounds and textures that are already in the game. </br>

===Code Block===
<pre>
<ThingDef ParentName="BaseHumanMakeableGun">
        <defName>MM_Our_Gun</defName>
        <label>Tutorial Gun</label>
        <description>A simple gun for learning purposes. (Mod learning purposes dont give it to a child or something)</description>
        <graphicData>
            <texPath>Things/Item/Equipment/WeaponRanged/Revolver</texPath>
            <graphicClass>Graphic_Single</graphicClass>
        </graphicData>
        <uiIconScale>1.4</uiIconScale>
        <soundInteract>Interact_Revolver</soundInteract>
        <!-- Now we define the weapon's stats. -->
        <statBases>
            <WorkToMake>2000</WorkToMake>
            <Mass>1.6</Mass>
            <AccuracyTouch>0.95</AccuracyTouch>
            <AccuracyShort>0.90</AccuracyShort>
            <AccuracyMedium>0.80</AccuracyMedium>
            <AccuracyLong>0.70</AccuracyLong>
            <RangedWeapon_Cooldown>1.5</RangedWeapon_Cooldown>
        </statBases>
        <!-- now we define the weapon's tags. -->
        <weaponTags>
            <li>SimpleGun</li>
            <li>Revolver</li>
        </weaponTags>
        <!-- Now we choose what will be used to make the weapon. -->
        <costList>
            <Steel>10</Steel>
            <Plasteel>1</Plasteel>
            <ComponentIndustrial>1</ComponentIndustrial>
        </costList>
        <!-- Now the weapon's requirements. -->
        <recipeMaker>
            <skillRequirements>
                <Crafting>5</Crafting>
            </skillRequirements>
        </recipeMaker>
        <!--verbs are what the weapon does. -->
        <verbs>
            <li>
                <verbClass>Verb_Shoot</verbClass>
                <hasStandardCommand>true</hasStandardCommand>
                <!-- Now we define the Bullet the weapon uses. -->
                <defaultProjectile>MM_Bullet</defaultProjectile>
                <warmupTime>0.9</warmupTime>
                <burstShotCount>3</burstShotCount>
                <ticksBetweenBurstShots>22</ticksBetweenBurstShots>
                <range>20</range>
                <soundCast>Shot_Revolver</soundCast>
                <soundCastTail>GunTail_Light</soundCastTail>
                <muzzleFlashScale>8</muzzleFlashScale>
            </li>
        </verbs>
        <!-- nice, we have shooting, but what happens when we get in melee? -->
        <tools>
            <li>
                <label>handle</label>
                <capacities>
                    <li>Blunt</li>
                </capacities>
                <power>7</power>
                <cooldownTime>3.1</cooldownTime>
            </li>
            <!-- you can add lots of melee but we will just add two. -->
            <li>
                <label>barrel</label>
                <capacities>
                    <li>Blunt</li>
                    <li>Poke</li>
                </capacities>
                <power>5</power>
                <cooldownTime>2.1</cooldownTime>
            </li>
        </tools>
    </ThingDef> 
</pre>
</br>
'''''If using the code snippets use "rwweapon" to generate the skeleton for the weapon. ''''' </br>
===Code Breakdown===
Thats a lot of code so lets break it down. </br>
====Names and Description====
<pre>
<ThingDef ParentName="BaseHumanMakeableGun">
        <defName>MM_Our_Gun</defName>
        <label>Tutorial Gun</label>
        <description>A simple gun for learning purposes.</description>
</pre>
We start by defining the weaponas a makeable gun. Then we give it a gameId (defName), a user friendly name (label) and a description. </br>
====Textures and Sounds====
<pre>            
<graphicData>
    <texPath>Things/Item/Equipment/WeaponRanged/Revolver</texPath>
    <graphicClass>Graphic_Single</graphicClass>
</graphicData>
<uiIconScale>1.4</uiIconScale>
<soundInteract>Interact_Revolver</soundInteract>
</pre>
now we define the texture (in this case we have specified the vanilla revolver texture) and the sound the weapon makes when a pawn picks it up. </br>
====Stats and Tags====
<pre>
<statBases>
    <WorkToMake>2000</WorkToMake>
    <Mass>1.6</Mass>
    <AccuracyTouch>0.95</AccuracyTouch>
    <AccuracyShort>0.90</AccuracyShort>
    <AccuracyMedium>0.80</AccuracyMedium>
    <AccuracyLong>0.70</AccuracyLong>
    <RangedWeapon_Cooldown>1.5</RangedWeapon_Cooldown>
</statBases>
<!-- now we define the weapon's tags. -->
<weaponTags>
    <li>SimpleGun</li>
    <li>Revolver</li>
</weaponTags>
</pre>
The stats are the weapons weight and its accuracy at different ranges. </br>

====Requirements and Cost====
<pre>
<costList>
    <Steel>10</Steel>
    <Plasteel>1</Plasteel>
    <ComponentIndustrial>1</ComponentIndustrial>
</costList>
<recipeMaker>
    <skillRequirements>
        <Crafting>5</Crafting>
    </skillRequirements>
</recipeMaker>
</pre>
As we are using BaseHumanMakeableGun the weapon will be at a machining table. We define the resources and skill required to make the weapon. </br>

====Verbs====
<pre>
<verbs>
    <li>
        <verbClass>Verb_Shoot</verbClass>
        <hasStandardCommand>true</hasStandardCommand>
        <!-- Now we define the Bullet the weapon uses. -->
        <defaultProjectile>MM_Bullet</defaultProjectile>
        <warmupTime>0.9</warmupTime>
        <burstShotCount>3</burstShotCount>
        <ticksBetweenBurstShots>22</ticksBetweenBurstShots>
        <range>20</range>
        <soundCast>Shot_Revolver</soundCast>
        <soundCastTail>GunTail_Light</soundCastTail>
        <muzzleFlashScale>8</muzzleFlashScale>
    </li>
</verbs>
</pre>
The verbs define (in this case) the how the weapon shoots. We define the projectile we made earlier, the warmup time and the burst shot count. Verbs is also where you define the range and shooting sound. </br>

====Melee====
<pre>
<tools>
    <li>
        <label>handle</label>
        <capacities>
            <li>Blunt</li>
        </capacities>
        <power>7</power>
        <cooldownTime>3.1</cooldownTime>
    </li>
</tools>
</pre>
In this case the tools are used to define the melee attacks of the weapon. Making sure to enclose each attack in a <li> tag give your attack a label, define the damage type, how much damage it does and lastly give it a cooldown time. </br>

Before we forget we need to close the "ThingDef" 
<pre>
</ThingDef>
</pre>
</br>

==Final Notes==
And with that we have a working weapon with a custom bullet and recipe. to inprove the weapon you could add a custom sound and texture or change the stats to your liking. The best way to learn is to experiment or look at other mods (I recommend looking at Vanilla Weapons Expanded as there mods keep there code clean and tidy). </br>

=Adding a Research Project=
Currently there weapon is unlocked by default. Lets add a research project to unlock it. </br>

==Making the File==
While we could add the research project to the same file as the weapon it is good practice to keep things tidy. So we lets make a new file in the "Defs" folder called "ResearchProjectDef.xml" </br>
Remember to add the Xml header and <pre> <Defs> </pre> tag. (Remember this can be done with "rwxxml")

==Adding the Research Project==
The Xml for the research project is shorter than the weapon however it still requires correct spelling and syntax. </br>
===Code Block===
<pre>
<ResearchProjectDef>
    <defName>tutorial_Research</defName>
    <label>My Mods Research</label>
    <description>Craft the mithical tutorial gun.</description>
    <baseCost>500</baseCost>
    <techLevel>Industrial</techLevel>
    <prerequisites>
        <li>Gunsmithing</li>
    </prerequisites>
    <researchViewX>9.00</researchViewX>
    <researchViewY>4.80</researchViewY>
</ResearchProjectDef>
</pre>
</br>
'''''If using the code snippets use "rwresearch" ''''' </br>
===Code Breakdown===
Ok lets break down the code. </br>
====Names and Description====
<pre>
<defName>tutorial_Research</defName>
<label>My Mods Research</label>
<description>Craft the mithical tutorial gun.</description>
</pre>
Just like the weapon we give the project a gameId, and a user friendly name and a description. </br>
====Cost, Tech Level and Prerequisites====
<pre>
<techLevel>Industrial</techLevel>
<prerequisites>
    <li>Gunsmithing</li>
</prerequisites>
</pre>
The tech level will scale the cost of the research project based on the colony's tech level (Tribal starts will be more expensive than crashlanded). the baseCost is the cost of the project before scaling for tech level. prerequisites are the research projects that must be completed before this project can be researched. (In this case we are requiring Gunsmithing) </br>
====Position====
<pre>
<researchViewX>9.00</researchViewX>
<researchViewY>4.80</researchViewY>
</pre>
This is the position of the project in the research tree. This may take some trial and error to get right (Or you could use a mod like "ResearchPowl" that makes the tree easier to navigate) </br>
===Locking the Weapon===
Right we have a research project but we need to tell the game to use it. to do this we need to edit our weapons recipeMaker. </br>
<pre>
<recipeMaker>
    <skillRequirements>
        <Crafting>5</Crafting>
    </skillRequirements>
    <researchPrerequisite>tutorial_Research</researchPrerequisite>
</recipeMaker>
</pre>
By simply adding the researchPrerequisite tag and giving it the gameId of the research project we have locked the weapon behind the research project. </br>

=Adding New Traits=
Traits are a great way to add new gameplay mechanics to your mod. For now we will be adding a trait that makes the colonist have a higher Crafting skill and lower carrying capacity. </br>

==Making the File==
To keep things tidy we will make a new file in the "Defs" folder called "TraitDef.xml" (Remember to add the Xml header and <pre> <Defs> </pre> tag. [Remember this can be done with "rwxxml"])

==Adding the Trait==
The Xml for the trait is quite straight forward once you know what each tag does (for code snippets use ""rwtrait") </br>
===Code Block===
<pre>
<TraitDef>
    <defName>Epic_crafting</defName>
    <commonality>1</commonality>
    <disabledWorkTags>
        <li>Animals</li>
    </disabledWorkTags>
    <degreeDatas>
        <li>
            <label>Epic Crafting</label>
            <description>[PAWN_nameDef] excels at crafting. [PAWN_pronoun] can carry heavy things and crafts very well</description>
            <degree>1</degree>
                <statOffsets>
                    <CarryingCapacity>25</CarryingCapacity>
                    <WorkSpeedGlobal>0.20</WorkSpeedGlobal>
                </statOffsets>
                <skillGains>
                    <li><key>Crafting</key><value>4</value></li>
                </skillGains>
        </li>
    </degreeDatas>
</TraitDef>
</pre>

===Code Breakdown===
Right lets break down the code. </br>
====Basic Tags====
<pre>
<defName>Epic_crafting</defName>
<commonality>1</commonality>
</pre>
Like the other defs we give the trait a gameId however this time we also give it a commonality. This is the chance that the trait will be given to a colonist. also note that the Label and Description are inside the degreeDatas tag and not the main tag. </br>
====Disabled Work Tags====
<pre>
<disabledWorkTags>
    <li>Animals</li>
</disabledWorkTags>
</pre>
Disabling work tags is a great way to make traits more unique. In this case we are disabling the animals work type. Remember to put all the work tags you want to disable inside there own <li> tag. </br>
====Degree Data====
<pre>
<degreeDatas>
    <li>
        <label>Epic Crafting</label>
        <description>[PAWN_nameDef] excels at crafting. [PAWN_pronoun] can carry heavy things and crafts very well</description>
        <degree>1</degree>
        <statOffsets>
            <CarryingCapacity>25</CarryingCapacity>
            <WorkSpeedGlobal>0.20</WorkSpeedGlobal>
        </statOffsets>
        <skillGains>
            <li><key>Crafting</key><value>4</value></li>
        </skillGains>
    </li>
</degreeDatas>
</pre>
The degree data is where we define the effects of the trait. This also includes the label (player friendly name) and description. Stat offsets are changes to the colonists stats. In this case we are increasing the colonists carrying capacity by 25 and increasing work speed by 20%. Skill gains are static increases to the colonists skills. In this case we are increasing the colonists crafting skill by 4. </br>

===Final Notes About Traits===
Congratulations you have made your first trait. for now it only changes stats and skills however traits can do a lot more. The best way to learn about the more advanced possibilities is to look at other mods that add traits. </br>

=Github=
As with the other tutorials I have made I have the example mods on [https://github.com/Burgess12/RimWorld-Mod-Tutorials github] for you to download and look at. </br>

=Next Steps=
Now that you have made a mod with content you can start to look at more advanced topics such as adding new buildings, and starting to use frameworks like Vanilla Expanded Framework. </br>
