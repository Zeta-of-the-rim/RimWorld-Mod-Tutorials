
{{BackToTutorials}}

This page is a tutorial on how to create a rimworld mod it will step you through the process of creating a mod from scratch. from basic files structure to writing code for your mod. This tutorial is aimed at people who have never created a mod before and are looking to get started. and is meant to be a updated guide to the old tutorials on the wiki.


=Introdusion=
Rimworld mods are created using XML and C# code. XML is used to define the content of the mod and C# is used to add functionality to the mod. For now we will focus on XML and later tutorials will cover C#.

To get started we will create the basic files and folders that are needed for a mod. We will then add some basic content to the mod and test it in game.

=Goal of this tutorial=
By the end of this tutorial you will have:
# Install software needed to make a mod
# Create a mod folder structure
# Edit the About.xml file
# Add a new item to the game
# Test the mod in game using the Debug menu

=Software=
To Get started making a mod with XML you will need to download the following:

* a copy of Rimworld (duh)
* a code editor
* [https://steamcommunity.com/sharedfiles/filedetails/?id=1847679158 RimPy] (This is a Mod manager that will make it easier to test your mod)
* [https://git-scm.com/ Git] Git can be scary at first but it is a very useful tool. and can be used to keep track of changes to your mod. (optional but highly recommended)

==Code Editor==
There are many code editors out there some of the most commonly used are:

* [https://code.visualstudio.com/ Visual Studio Code] is a free code editer and has a lot of useful features and tools (this is what I will use).
* [https://www.sublimetext.com/ Sublime Text] is a free code editor that popular .
* [https://notepad-plus-plus.org/ Notepad++] is a very light weight code editor that is very easy to use however it is missing some features that make it less useful for larger projects.


'''''About IDEs:'''''
IDEs are Integrated Development Environments. They are a code editor and a compiler all in one. They are very useful for larger projects but can be overkill for smaller projects. IDEs are also very resource intensive and can slow down your computer. I would recommend using a code editor for now and when you are ready to start using C# you can look into IDEs.

=Making the folder structure=
'''''There are mod templates available for quick setup however it is recommended to create the folder structure manually at least once to get a better understanding of how mods work.'''''
To start making a mod we need to create a folder for the mod. This folder will contain all the files and folders that make up the mod. to keep things organized we will create a folder in rimworlds mod local folder. this is located at: <br/><pre>(RimWorldInstallFolder)/Mods/</pre>
'''''Note: is is not recommended to put your mod in the steam mods folder'''''

==Creating the about file==
Now lets make an About folder inside the mod folder. This folder will contain information about the mod and the mods preview image.

Inside the About folder we will create a file called About.xml. This file will contain the information about the mod. inside the file we will add the following code: <br/>

<pre>
<?xml version="1.0" encoding="UTF-8"?> <!-- Comments in XML look like this-->
</pre>
<br/>
This is the first line of every XML file. it tells the computer that this is an XML file and what encoding to use. (get used to seeing this line in every XML file you make) <br/>
now we will add the following code to the file: <br/>
<pre>
<ModMetaData>
    <name>Mod Name Here</name> <!-- This is the name of the mod -->
    <author>Your Name Here</author> 
    <packageId>yourName.ModName</packageId> <!-- It is best to use this format-->
    <description>Super Cool Mod</description> <!-- Be Creative the description is what people will see when they look at your mod -->
    <supportedVersions>
        <li>1.4</li>
    </supportedVersions> <!-- This is the version of rimworld that the mod is compatible with -->
</ModMetaData> <!-- be sure to close all tags you open -->
</pre>
<br/>
'''''XML is picky about spacing, formatting and Capitalization. if you get an error when loading your mod it is most likely because of a typo or missing tag''''' <br/>
Now save the file and close it. <br/>
'''''Note: the name of the file must be exactly "About.xml"'''''
open RimPy and sort by local mods. you should see your mod listed. if you click on it you should see the information you entered in the About.xml file. <br/>

'''''When adding a preview image to your mod you must name the image "Preview.png" and place it in the About folder the image should be 512x512 pixels and must be under 1mb'''''

==Creating the other folder==
Now lets make a Defs folder inside the mod folder. This folder will contain all the XML files that define the content the mod will add. <br/>
start by creating a folder called "Defs" inside the mod folder, inside the Defs folder create a file called "ThingDefs.xml" <br/>
in the root of the mod folder create a folder called "Patchs". this folder will contain XML files that will be used to patch existing content in the game. inside the Patchs folder create a file called "ThingDefs_Patch.xml" <br/>
lets also create a folder called "Textures" inside the mod folder. this folder will contain all the images that will be used in the mod. <br/>

your mod folder should now look like this: <br/>
<pre>
ModName
    About
        About.xml
        Preview.png
    Defs
        ThingDefs.xml
    Patchs
        ThingDefs_Patch.xml
    Textures
</pre>

=Adding content to the mod=
Now that we have the basic folder structure set up we can start adding content to the mod.
==Adding a new item==
Lets start by added a new item to the game. open the "ThingDefs.xml" file and add the following code: <br/>

<pre> 
<?xml version="1.0" encoding="UTF-8"?>
</pre>
Remember this is the first line of every XML file.
<br/>

<pre>
<Defs>
    <ThingDef ParentName="ResourceBase">
        <thingClass>ThingWithComps</thingClass>
        <defName>MM_Resource</defName>
        <label>Resource</label>
        <description>Resource</description>
        <statBases>
            <MarketValue>1</MarketValue>
            <MaxHitPoints>300</MaxHitPoints>
            <Mass>1</Mass>
            <Flammability>0</Flammability>
            <DeteriorationRate>0.1</DeteriorationRate>
            <Beauty>2</Beauty>
        </statBases>

    </ThingDef>
</Defs>
</pre>
Now save the file and close it. In RimPy enable the mod and start the game. In Settings under general enable Development Mode.
Now on the main menu there should be a new button called "Dev quicktest", This will start a new game on a test map. Once the game has loaded open the Debug menu, in the Debug menu click on the "Spawn Thing" button. In the "Spawn Thing" menu type in the def name of the item you just added. Click on the item then click anywhere on the map to spawn it.
<br/>
Congratulations you have just added your first item to the game. 

==Adding a texture to the item==
While we have added an item to the game currently it has no texture. and looks ugly. to fix this we will add a texture to the item. to start we will need to add a texture to the mod. for now lets grab a texture from the rimworld wiki (this means the image will be the correct size and format). 
Heres what your texture folder should look like: <br/>
<pre>
Textures
    Things
        Item
            Resource
                Resource.png
</pre>
It is best to organize your textures into folders that match the folder structure of the game. after you have added your texture to the mod folder open the "ThingDefs.xml" file and add the following code to your items ThingDef:
<br/>
<pre>
<graphicData>
    <texPath>Things/Item/Resource/Resource</texPath>
    <graphicClass>Graphic_Single</graphicClass>
</graphicData>
</pre>
'''''Note how you dont add the file extension to the texture path.''''' <br/>
Now that looks much better!
If you consider yourself an artist you can make your own textures (you wont be getting a how to from me on that one though). <br/>

==Adding more complex properties==
Now that we have added a new item to the game we can add some more features to it. to start we will make the item rot. open the "ThingDefs.xml" file and add the following code to your items ThingDef: <br/>
<pre>
<comps>
     <li Class="CompProperties_Rottable">
        <daysToRotStart>2</daysToRotStart> <!-- This is the number of days it takes for the item to start rotting -->
        <daysToDessicated>3</daysToDessicated> <!-- This is the number of days it takes for the item to start dessicating -->
    </li>
</comps>
</pre>
the best way to learn how to add more features to your items is to look at the existing items in the game. you can find the XML files for the existing items in the RimWorld install folder located at: <br/>
<pre>
steamapps/common/RimWorld/Data/Core(Or whatever DLC you have)/Defs/
</pre>
<br/>

=GitHub files=
All the files made in this tutorial can be found [https://github.com/Burgess12/RimWorld-Mod-Tutorials here] on GitHub. this allows you to download the files and use them as a reference when making your own mods.

Github is a great tool for sharing code and is especially useful for when you are ready to start programming in C#.

=Next steps=
After you have completed this tutorial you should have a basic understanding of how to make a mod for RimWorld. now you can start adding more features to your mod. The next tutorial will walk you through how to add a Weapon, recipe and a trait to your mod.