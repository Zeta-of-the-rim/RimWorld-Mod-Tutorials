{{BackToTutorials}}

This page is a tutorial on how to create a rimworld mod it will step you through the process of creating a mod from scratch. from basic files structure to writing code for your mod. This tutorial is aimed at people who have never created a mod before and are looking to get started. and is meant to be a updated guide to the old tutorials on the wiki.

This is a follow up to my [[Modding Tutorials/Xml_Adding_Weapons_Traits_Research|previous tutorial]] on how to make a mod. if you have not:
# Started adding items with xml
# Added basic traits
# Added and linked research

Then you should go back a read the [[Modding_Tutorials/Geting_started_with_mods|previous tutorial]].

=Goal of this tutorial=
By the end of this tutorial you will have:
# Made a patch for a existing item
# Making the assault rifle even more powerful


=Useful Tools=
There are a few tools that will make your life easier when modding Rimworld.
# [https://github.com/Burgess12/Rimwold-Dotnet-Template Rimworld dotnet template] is a mod template that can be used to quickly set up a mod.
# [https://raw.githubusercontent.com/Burgess12/RimWorld-Mod-Tutorials/master/2.%20Wepons%20and%20Traits/CodeSnippets.json Rimworld code snippets] is a collection of code snippets that can be used to quickly add code to your mod.
# On any game map with dev mode click the Magnifying glass on the top of the screen will open the Debug inspector. Next to the visibility button is toggle for "Deep inspection mode" this will allow you to see the xml of any object in the game. This can be used to find the xpath for any value in the game.
=Patching=
Patching is the process of adding or changing exsisting values in the game. For simple mods this can be done with xml.

==Patching with xml==
For this tutorial we will be making the vanilla revolver do 100 damage instead of 12. To do this we will need to patch the revolver's stats.
===Code Block===
<pre>
<?xml version="1.0" encoding="utf-8"?>
<Patch>
    <Operation Class="PatchOperationReplace">
        <xpath>/Defs/ThingDef[defName = "Bullet_Revolver"]/projectile/damageAmountBase</xpath>
        <value>
            <damageAmountBase>100</damageAmountBase>
        </value>
    </Operation>
</Patch>
</pre>
</br>
'''''If using the code snippets use "rwpatch" to generate the basic XML. ''''' </br>

===Breakdown===
To start we add the xml header and the patch tag.
====Operation====
The operation tag is used to tell the game what we want to do with the patch. In this case we want to use the PatchOperationReplace class. This class will replace the value of the xpath with the value tag.

what is happening is that the game is looking for the xpath and replacing the value with the value tag. 
{| class="wikitable" style="margin-left: auto; margin-right: auto;"
! Our Patch !! Before !! After
|-
| style="vertical-align: top;" |<pre>
<Operation Class="PatchOperationReplace">
    <xpath>/Defs/ThingDef[defName = "Bullet_Revolver"]/projectile/damageAmountBase</xpath>
    <value>
        <damageAmountBase>100</damageAmountBase>
    </value>
</Operation>
</pre>
| style="vertical-align: top;" |<pre>
<projectile>
    <damageDef>Bullet</damageDef>
    <damageAmountBase>12</damageAmountBase>
    <stoppingPower>1</stoppingPower>
    <speed>55</speed>
</projectile>
</pre>
| style="vertical-align: top;" |<source lang="xml">
<projectile>
    <damageDef>Bullet</damageDef>
    <damageAmountBase>100</damageAmountBase>
    <stoppingPower>1</stoppingPower>
    <speed>55</speed>
</projectile>
</source>
|-
|}
====xpath====
The xpath tag needs to point to the value you want to change and must be the exact path including all tags the value is in. Because of this it is best to find the value you want to change in its XML file, before you start on the patch. This will make it easier to find the xpath (Remember the Defs of the base game and its DLC's are found in the Data folder in the game folder). This method can also change the values of any mod that uses xml to add content to the game. 

====value====
Now you have pointed to the value you want to change, its time to change it. The value tag is where you put the new value. As we are using "PatchOperationReplace" anything in the value tag will replace the value of the xpath.

==Patching Sequence==
Now that we have a basic understanding of how to patch the game with xml lets look at a more complex example. for this example we will make the assault rifle fire explosive bullets. To do this we will need to patch the assault rifle's stats and add a new projectile.

===Making the explosive bullet===
First we need to make a new projectile that will be used by the assault rifle. 
<pre>
<ThingDef ParentName="BaseBullet"> <!-- even though this is a explosive it is still a bullet -->
    <defName>mm_Twist</defName>
    <label>explosive</label>
    <graphicData>
        <texPath>Things/Projectile/LauncherShot</texPath>
        <graphicClass>Graphic_Single</graphicClass>
        <shaderType>TransparentPostLight</shaderType>
    </graphicData>
    <thingClass>Projectile_Explosive</thingClass>
    <projectile>
        <speed>35</speed>
        <damageDef>Bomb</damageDef> <!-- using the vanilla bomb damage -->
        <explosionRadius>1.5</explosionRadius>
        <arcHeightFactor>0.2</arcHeightFactor>
        <shadowSize>0.6</shadowSize>
    </projectile>
</ThingDef>
</pre> 
</br>
Just like the previous tutorial but with a few changes.

# In "DamageDef" instead of using "Bullet" we are using "Bomb" this will make the bullet do explosive damage.
# The bullet has "explosionRadius", "arcHeightFactor" and "shadowSize" these are the values that control the explosion.

===Patching the assault rifle===
Now that we have a new projectile we need to patch the assault rifle to use it.
<pre>
<Operation Class="PatchOperationSequence">
    <success>Normal</success>
    <operations>
        <li Class="PatchOperationReplace">
            <xpath>/Defs/ThingDef[defName = "Gun_AssaultRifle"]/verbs/li/defaultProjectile</xpath>
            <value>
                <defaultProjectile>mm_Twist</defaultProjectile>
            </value>
        </li>
        <!-- Now we need to add the Defs that exsplosive bullets need -->
        <li Class="PatchOperationAdd">
            <xpath>/Defs/ThingDef[defName = "Gun_AssaultRifle"]/verbs/li</xpath>
            <value>
                <forcedMissRadius>1.9</forcedMissRadius>
                <targetParams>
                    <canTargetLocations>true</canTargetLocations>
                </targetParams>
            </value>
        </li>
    </operations>
</Operation>
</pre>
</br>

===Breakdown===
By using the "PatchOperationSequence" class we can make a patch that does multiple things. The first thing we do is replace the default projectile of the assault rifle with our new explosive bullet. However now that the assault rifle is using a explosive bullet we need to add a few more values to the assault rifle's xml. This is done by using the "PatchOperationAdd" class. By entering the xpath of the assault rifle's verbs we can add a forced miss radius and allow the assault rifle to target locations.

</br>
Enjoy your new explosive assault rifle.




==Other Patching Operations==
There are a few other patching operations that can be used to change the values of the game. While you can get away with using Add, Remove and Replace for most basic patches there are a few other operations that can be used to make more complex patches. It can be useful to familiarize yourself with these [[Modding_Tutorials/PatchOperations| operations]].

=Github=
As with the previous tutorial example code with comments can be found on [https://github.com/Burgess12/RimWorld-Mod-Tutorials github].

=Next Tutorial=
Next we will look at a couple frameworks that can be used to make advanced mods easier to make.