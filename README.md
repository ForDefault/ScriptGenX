# ScriptGenX
Script Generator and Executor
>Works great for testing scripts quickly with ChatGPT 

- The install option: 

`CLI alias means I can type genx in the CLI. The ScriptGenX.sh will launch. This allows me to use a current script in my clipboard to launch anywhere in a directory I want. 
Either way its the same script just how you execute it.`

### **CLI Alias Install Option :**
```
REPO_URL="https://github.com/ForDefault/ScriptGenX.git" && \
REPO_NAME=$(basename $REPO_URL .git) && \
username=$(whoami) && \
git clone $REPO_URL && \
cd $REPO_NAME && \
sudo apt-get update && sudo apt-get install -y xclip && \
chmod +x scriptgenx.sh && \
if ! grep -q 'alias genx=' ~/.bashrc; then \
  echo 'alias genx="/home/'"$username"'/'"$REPO_NAME"'/scriptgenx.sh"' >> ~/.bashrc; \
fi && \
source ~/.bashrc && \
echo "Installation complete. You can now use 'genx' to run the script from anywhere."

```

**Script Generator and Executor** does all of that for you. It auto-detects whether you're working with a Shell or Python script, generates the file, sets the right permissions, and even gives you the option to run it immediately—all while copying the script to your clipboard and cleaning up afterwards. It's the simple, efficient way to manage your scripts without the extra hassle.

##### **What it really does** on your clipboard will be a custom echo command for your code to: create document, chmod +x, and option to run, all from pasting your clipboard. Also works well for echo placements in larger code. 

This script is designed to dynamically generate and optionally execute a user-provided script based on the content type (Shell or Python). The script also ensures that the generated script is copied to the clipboard and handles the deletion of intermediate files based on user input.

## Features

- **Dynamic Script Generation**: Automatically detects whether the provided script is a Shell or Python script.
- **Optional Execution**: Prompts the user to decide whether the generated script should be executed immediately.
- **Clipboard Integration**: Copies both the final script and the intermediate script to the clipboard for easy pasting.

## Usage

1. Run the script.
2. Paste the script content when prompted.
3. Confirm the script content.
4. Enter the desired filename (without extension).
5. The script will generate the final script, optionally execute it, copy it to the clipboard, and delete intermediate files based on your choices.

### Example

After running the script and providing the script content, you will be asked whether you want to execute the generated script immediately. Depending on your choice:
- If **yes**: The script is executed and remains on disk.
- If **no**: The script is copied to the clipboard, and the file is deleted.

## How It Works

1. Start script
2. Capture script content from the user
3. Determine the script type based on the first line (Python or Shell)
4. Prompt the user for the desired filename (without extension)
5. Remove any existing extensions from the filename
6. Generate the intermediate script (`generate_filename.sh`) that:
   - **a.** Creates the final script (`filename.extension`) with the captured content
   - **b.** Makes the final script executable
   - **c.** Asks the user: "Do you want to execute the script now?" (yes/no)
     - **If "yes":**
       - Executes the final script (`filename.extension`)
       - Skips deletion of the final script
     - **If "no":**
       - Copies the final script to the clipboard
       - Deletes the final script (`filename.extension`)
   - **d.** Copies the content of `generate_filename.sh` to the clipboard (When pasted, this will ask if you want to run the file right now or not)
   - **e.** Always deletes itself after execution (`generate_filename.sh`)
7. Run the intermediate script (`generate_filename.sh`)
8. Copy the content of `generate_filename.sh` to the clipboard after it runs
9. Delete the intermediate script (`generate_filename.sh`) after it runs
10. Display a message confirming that the script was generated, made executable, and copied to the clipboard

## Installation

Simply download the script and make it executable:

```bash
chmod +x your_script_name.sh
