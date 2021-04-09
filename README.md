# Import notes from Notion to Joplin
Simple script to remove Notion's hash id from note titles.

Firstly clone this project or download the `notion-import.sh` file to a folder.

You must download and install the [terminal version of joplin](https://joplinapp.org/terminal/). Make sure it is in your PATH (to certify you can run `joplin help`.

Export a notebook in Notion with the "Export Markdown and CSV" option.

Unzip and move the content of folder named after the notebook to the folder where the notion-import.sh script is.

Create a notebook in Joplin with `joplin mkbook <name_of_your_notebook>`.

Write down the hash of the notebook you just created. To list all the notebooks with their hashes use `joplin ls / -l`. The hash is the first column (a 5 character random string). To see only the hash run `joplin ls / -l | grep <name_of_the_notebook> | awk '{print $1}'`, but you need to have awk installed.

Finally run the script with:
```
./notion-import.sh <notebook_hash>
```

Currently this script does not import images and other forms of attachments.
