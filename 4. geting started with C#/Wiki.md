{{BackToTutorials}}

This page is a tutorial on how to create a rimworld mod it will step you through the process of creating a mod from scratch. from basic files structure to writing code for your mod. This tutorial is aimed at people who have never created a mod before and are looking to get started. and is meant to be a updated guide to the old tutorials on the wiki.

This tutorial will introduce you to more advanced modding concepts. if you have not:

# Made a file structure

# Added basic items with xml

# Used Patch Operations to change existing values

Then you should go back a read the previous tutorials.

=Goal of this tutorial=
By the end of this tutorial you will have:

# Set up a c# environment

# Added the Rimworld Reference Assemblies using NuGet

# Created a basic c# class

# Printed a message to the debug log

=Choosing a IDE=
While Visual Studio Code can be used to write c# code for Rimworld it is not recommended as it is missing some features that are useful for Rimworld modding.

<br>
The go to IDE for Rimworld modding is [https://visualstudio.microsoft.com/vs/ Visual Studio]. Visual Studio is a full featured IDE that is free for personal use, it is available for Windows and Mac (but not Linux). A good alternative (especially for Linux users) is Rider from [https://www.jetbrains.com/rider/ Jetbrains]. Rider is free for students and just as good as Visual Studio, however it does require a bit more setup to get working with Rimworld.

=Setting up your IDE=
==Visual Studio==
To set up Visual Studio start by downloading and installing it from [https://visualstudio.microsoft.com/vs/ here]. The installer will ask you what you want to install, you only need to install the ".NET desktop development" workload '''''Make sure you have the ".NET framework 4.7.2 SDK" selected'''''. Once installed you can open Visual Studio and in new project window select "Class Library (.NET Framework)" and click next. On the next screen you can name your project, select where you want to save it and what framework version you want to use. Rimworld uses .NET 4.7.2 so make sure you have that selected (if the option is not there you will need to install the .NET framework from [https://dotnet.microsoft.com/download/dotnet-framework/net472 here]). Once you have done that click create and you will have a new project ready to go.

==Rider==
To set up Rider start by downloading and installing it from [https://www.jetbrains.com/rider/ here]. Rider does not automatically install the .NET framework so you will need to install it manually. You can download the .NET framework from [https://dotnet.microsoft.com/download/dotnet-framework/net472 here] make sure to install the Developer Pack, after this you can open Rider and create a new project. In the new project window select "Class Library" from the NET Framework section and click next. On the next screen you can name your project and where you want to save it, make sure you have ".NET Framework 4.7.2" selected and click create. You will now have a new project ready to go.

=Adding the Rimworld Reference Assemblies=
While you can add the Rimworld Reference Assemblies manually it is much easier and faster to use NuGet (in visual studio NuGet is located in the "Tools" menu, in Rider it is located at the bottom of the window). To add the Rimworld Reference Assemblies open NuGet and search for [https://www.nuget.org/packages/Krafs.Rimworld.Ref RimRef] by Krafs click install. IF USING VISUAL STUDIO when prompted to choose between "packages.config" and "PackageReference" select "PackageReference" and click ok. IF USING RIDER before clicking install open settings, search for "NuGet" and under default package management format select "PackageReference" then click ok and install RimRef. You will now have the Rimworld Reference Assemblies added to your project.

