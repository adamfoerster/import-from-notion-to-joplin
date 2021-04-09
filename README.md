# Import notes from Notion to Joplin
Simple script to import Notion's zip markdown exports.

Firstly clone this project or download the `notion-import.sh` file to a folder.

You must download and install the [terminal version of joplin](https://joplinapp.org/terminal/). Make sure it is in your PATH (to certify you can run `joplin help`.

Export a notebook in Notion with the **Export Markdown and CSV** option and check the **Include subpages** option.

Finally run the script with:
```
./notion-import.sh <path_to_the_zip_file> [<name_of_the_notebook_to_be_created>]

```
*Note that the name of the notebook is optional. If you don't include it the notebook will be created with the name exported from Notion.*

**Example:**
```
./notion-import.sh "/home/adam/export.zip" "My New Notebook"
```
In this example we consider that I have downloaded the export file to `/home/adam/export.zip` and that I want to name my new notebook as **My New Notebook**.
Currently this script does not import images and other forms of attachments.
