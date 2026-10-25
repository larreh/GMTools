# GMTools

A lightweight AI slop utility addon for World of Warcraft (WotLK 3.3.5) designed for Game Masters running TrinityCore, AzerothCore, or similar emulator servers. It automates the process of resetting and unbinding instance lockouts for an entire 25-man raid or 5-man party roster with a single click.

## Description

Manually unbinding instances for large groups using `.instance unbind all` can be tedious and slow. Because of the security limitations in the 3.3.5 client, standard macro characters are capped at 255, and automated scripts cannot natively switch targets frame-by-frame. 

**GMTools** resolves this by dynamically compiling your current group or raid roster into an unlimited, secure background engine. By linking this engine to a dedicated macro button, you can mass-unbind your entire group instantly without typing a single slash command or copying names manually.

## Installation

1. Download the `GMTools` repository.
2. Extract or move the `GMTools` folder into your World of Warcraft directory under:
   `World of Warcraft\Interface\AddOns\`
3. Ensure the folder name is exactly `GMTools` and contains `GMTools.toc`, `GMTools.lua`, and `UnbindFunctions.lua`.
4. Restart your game or type `/reload` if you were already logged in.

## Usage Instructions

Getting the tool running takes a simple, one-time initialization process:

1. **Initialize the Addon:** Type `/gmt unbind` in the chat frame. This prepares the backend architecture and generates your macro placeholder.
2. **Place the Button:** Open your game's macro menu (`/macro`). Look for a newly created character macro named **GM_Unbind**. Drag this icon down onto any open slot on your action bars.
3. **One-Click Automation:** You are now completely done typing commands! Whenever you are in a party or a 25-man raid dungeon, simply click that **GM_Unbind** action bar button. 

The button will automatically scan your live group composition, rewrite the secure target targets in the background, cycle through the targets, and dispatch the `.instance unbind all` server instructions instantly.
