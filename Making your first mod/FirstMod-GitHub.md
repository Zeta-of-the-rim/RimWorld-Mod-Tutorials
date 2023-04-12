# Making your first mod
This page is a tutorial on how to create a rimworld mod it will step you through the process of creating a mod from scratch. from basic files structure to writing code for your mod. This tutorial is aimed at people who have never created a mod before and are looking to get started. and is meant to be a updated guide to the old tutorials on the wiki.

## Introdusion
Rimworld mods are created using XML and C# code. XML is used to define the content of the mod and C# is used to add functionality to the mod. For now we will focus on XML and later tutorials will cover C#.

To get started we will create the basic files and folders that are needed for a mod. We will then add some basic content to the mod and test it in game.

## Software
To Get started making a mod with XML you will need to download the following:

* a copy of Rimworld (duh)
* a code editor
* [RimPy](https://steamcommunity.com/sharedfiles/filedetails/?id=1847679158) (This is a Mod manager that will make it easier to test your mod)
* [Git](https://git-scm.com/ ) Git can be scary at first but it is a very useful tool. and can be used to keep track of changes to your mod. (optional but highly recommended)

### Code Editor
There are many code editors out there some of the most commonly used are:

* [Visual Studio Code](https://code.visualstudio.com/ ) is a free code editer and has a lot of useful features and tools (this is what I will use).
* [Sublime Text](https://www.sublimetext.com/) is a free code editor that popular .
* [Notepad++](https://notepad-plus-plus.org/ ) is a very light weight code editor that is very easy to use however it is missing some features that make it less useful for larger projects.

***About IDEs:***
IDEs are Integrated Development Environments. They are a code editor and a compiler all in one. They are very useful for larger projects but can be overkill for smaller projects. IDEs are also very resource intensive and can slow down your computer. I would recommend using a code editor for now and when you are ready to start using C# you can look into IDEs.

## Making the folder structure
***There are mod templates available for quick setup however it is recommended to create the folder structure manually at least once to get a better understanding of how mods work.***
To start making a mod we need to create a folder for the mod. This folder will contain all the files and folders that make up the mod. to keep things organized we will create a folder in rimworlds mod local folder. this is located at: <br/>
<pre>(RimWorldInstallFolder)/Mods/</pre>
***Note: is is not recommended to put your mod in the steam mods folder***

### Creating the about file
Now lets make an About folder inside the mod folder. This folder will contain information about the mod and the mods preview image.

Inside the About folder we will create a file called About.xml. This file will contain the information about the mod. inside the file we will add the following code: <br/>

```xml
<?xml version="1.0" encoding="UTF-8"?> <!-- Comments in XML look like this-->
```
<br/>
This is the first line of every XML file. it tells the computer that this is an XML file and what encoding to use. (get used to seeing this line in every XML file you make) <br/>
now we will add the following code to the file: <br/>

```xml
<ModMetaData>
    <name>Mod Name Here</name> <!-- This is the name of the mod -->
    <author>Your Name Here</author> 
    <packageId>yourName.ModName</packageId> <!-- It is best to use this format-->
    <description>Super Cool Mod</description> <!-- Be Creative the description is what people will see when they look at your mod -->
    <supportedVersions>
        <li>1.4</li>
    </supportedVersions> <!-- This is the version of rimworld that the mod is compatible with -->
</ModMetaData> <!-- be sure to close all tags you open -->
```
<br/>
Now save the file and close it. <br/>

***Note: the name of the file must be exactly "About.xml"***
open RimPy and sort by local mods. you should see your mod listed. if you click on it you should see the information you entered in the About.xml file. <br/>

***When adding a preview image to your mod you must name the image "Preview.png" and place it in the About folder the image should be 512x512 pixels and must be under 1mb***

==Creating the other folder=
Now lets make a Defs folder inside the mod folder. This folder will contain all the XML files that define the content the mod will add. <br/>
start by creating a folder called "Defs" inside the mod folder, inside the Defs folder create a file called "ThingDefs.xml" <br/>
in the root of the mod folder create a folder called "Patchs". this folder will contain XML files that will be used to patch existing content in the game. inside the Patchs folder create a file called "ThingDefs_Patch.xml" <br/>
lets also create a folder called "Textures" inside the mod folder. this folder will contain all the images that will be used in the mod. <br/>

your mod folder should now look like this: <br/>

```xml
ModName
    About
        About.xml
        Preview.png
    Defs
        ThingDefs.xml
    Patchs
        ThingDefs_Patch.xml
    Textures
```

## Adding content to the mod

### Adding a new item
Now that we have the basic folder structure set up we can start adding content to the mod. to start we will add a new item to the game. open the "ThingDefs.xml" file and add the following code: <br/>

```xml 
<?xml version="1.0" encoding="UTF-8"?>
```
Remember this is the first line of every XML file.
<br/>
```xml 
<Defs>
    <ThingDef>
        <defName>ModName_ItemName</defName> <!-- This is the name of the item. it must be unique and follow the format ModName_ItemName -->
        <label>Item Name</label> <!-- This is the name of the item that will be displayed in game -->
        <description>A description of the item</description> 
        <graphicData>
            <texPath><!-- This is the path to the image that will be used for the item --></texPath> 
            <graphicClass>Graphic_Single</graphicClass> <!-- This is the type of graphic that will be used for the item leave this as Single for now -->
        </graphicData>
        <stackLimit>75</stackLimit> <!-- This is the max number of items that can be stacked in one tile -->
        <category>ResourcesRaw</category> <!-- This is the category that the item will be placed in -->
        <thingClass>Thing</thingClass> <!-- This is the class that the item will use -->
        <statBases>
            <MarketValue>10</MarketValue> <!-- This is the value of the item -->
        </statBases>
    </ThingDef>
</Defs>
```
Now save the file and close it. In RimPy enable the mod and start the game. In Settings Enable the "Dev Mode" option. Now on the main menu click on the "Start Test Map" button. This will start a new game with a test map. Once the game has loaded open the Debug menu, in the Debug menu click on the "Spawn Thing" button. In the "Spawn Thing" menu type in the name of the item you just added. Click on the item then click anywhere on the map to spawn it.
<br/>
Congratulations you have just added your first item to the game. 

### Adding a new item that rots
Now that we have added a new item to the game we can add some more features to it. to start we will make the item rot. open the "ThingDefs.xml" file and add the following code to your items ThingDef: <br/>
<comps>
     <li Class="CompProperties_Rottable">
        <daysToRotStart>2</daysToRotStart> <!-- This is the number of days it takes for the item to start rotting -->
        <daysToDessicated>3</daysToDessicated> <!-- This is the number of days it takes for the item to start dessicating -->
    </li>
</comps>

