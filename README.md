# Confluence-Export
As Confluence Spaces become larger, exporting to a static HTML site becomes more time consuming, more likely to fail, and more likely to have errors in the output. The obvious solution is to export smaller portions of a Space as a Sub-Space. However, the result is a standalone HTML site that cannot just be copy-pasted into a pre-exported result of a larger Space. Even if that were the case, the manual actions to do so are tediuous, error-prone, and unclear. This is compounded when you have integrated the result as lightly as possible into a different CSS regime for display on a 3rd party site. 

This repo is a template and toolset for a lightweight and extensible system by which such exports can be better automated. While you still must manually export certain portions of your Confluence Space, and, after initial setup, make a few local changes for any major additions/subtractions of export scope, the rest of the process is automated beyond calling a single bash script when you are ready to integrate the new export. 

Additionally, this repo provides instructions on a systematic process by which to decide how to export sub-Spaces and change the system as the Confluence space changes in scale.

By using this repo, the speed & reliability of your Confluence Space exports will be greatly increased, while the complexity & manual work will be greatly reduced.

## Definitions
Before we go any further, to assist in discussing concepts more succinctly and more accurately, the following is a definition of terms that are used for this project:

Space
Sub-Space
Multi Export
Parent Export
Child Export
Space Export Compiler
Export Root Directory - must have a push.sh file in it in order to manage unpacking the .zip file and moving the appropriate files to the Exported Space
Exported Space Target

## Confluence Exporter Installation
The following are steps to use this repo in your own dev projects.


## Integrating Confluence Exports with Another Static HTML Site with this Tool
If you are hosting the results of a Confluence export within another static HTML site, such as Github's free option, the following are steps on how to integrate the two using this tool.


## Confluence Export
The following are the steps to export your Confluence Space, and then use this repo to automate integrating the results. Note that **step 8** is the only one involving this repo. The rest are manual steps that you need to do regardless with Confluence.

1. Go to the Space on Confluence that you want to export from.
2. Select `Space Settings > Manage Space > Export Space` 
  - Look in left sidebar at the top section, for `Space Settings` (next to a gear)
3. Select `Export Formats > HTML`, then `Next >>`

4. `Export a zipped HTML File >`
  - **For large spaces/multi exports**: `Export a zipped HTML File > Select what to Export`
    - This opens the tree navigator for the site.
      - Selecting/deselecting parents selects/removes all children.
      - For each separate export, select root node down to landing page of next child export (or all depths if there are no child exports). 
  - **For single small space**: `Export a zipped HTML File > Export each page, with attachments`.

6. Click `Export` (at bottom of screen)
7. Once space has finished exporting, click `Download here` beneath the status bar. This brings up a dialog for selecting where to save the .zip file. From here, navigate to the corresponding Export Root Directory of the Space Export Compiler.

8. To export another section in the same session:
  - Back up once in the browser
  - Toggle the `Export a zipped HTML file` options to `Export each page...` and back to `Select what to export`
  - Repeat steps 4a-6

9. Once all exports are complete: At the Root of the Space Export Compiler, execute the `run.sh` script to update the Exported Space Target

Congratulations! Your exported Confluence Space has now been updated!

## Changing Sub-Space Scopes
As your Space grows and shrinks, you may decide to subvide spaces into Sub-Spaces and Sub-Spaces into even further Sub-Spaces, or you may choose to integrate these exported parts. The following are steps on how to do that with this tool.

## Bash Script Arguments
-d/--deasdasd

