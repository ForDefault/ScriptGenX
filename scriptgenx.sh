#!/bin/bash

# Function to capture script content
capture_script() {
    script_content=""
    echo "Please paste your script below. When you're done, press Ctrl+D:"

    while IFS= read -r line; do
        script_content+="$line"$'\n'
    done

    # Confirm the content
    clear
    echo "You pasted the following script:"
    echo "---------------------------------"
    echo "$script_content"
    echo "---------------------------------"
    read -p "Is this correct? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        echo "Let's try again."
        capture_script
    fi
}

# Capture the script content
capture_script

# Detect the script type based on the first line
first_line=$(echo "$script_content" | head -n 1)
if [[ $first_line == "#!/bin/bash"* ]]; then
    extension=".sh"
else
    extension=".py"
fi

# Prompt for the file name
read -p "Enter the desired filename: " filename

# Remove any existing extensions from the filename
filename="${filename%.*}"

# Generate the output script using the simpler EOF technique
cat <<SCRIPTGENERATOR > generate_$filename.sh
#!/bin/bash

cat <<'EOF' > "$filename$extension"
$script_content
EOF

chmod +x "$filename$extension"

# Optionally execute the script after generating it
read -p "Do you want to execute the script now? (y/n): " execute_now
if [[ "\$execute_now" == "y" ]]; then
    if [[ "$extension" == ".py" ]]; then
        python3 "$filename$extension"
    else
        ./"$filename$extension"
    fi
fi

# Copy the script to the clipboard
cat "$filename$extension" | xclip -selection clipboard

# If "no" is selected, delete the generated script
if [[ "\$execute_now" != "y" ]]; then
    rm "$filename$extension"
fi

# Delete this script after execution
rm -- "\$0"
SCRIPTGENERATOR

# Make the generated script executable
chmod +x generate_$filename.sh

# Run the generated script which will generate the final script and delete itself
./generate_$filename.sh

# Clean up by deleting the generate_##.sh script
rm -- "generate_$filename.sh"

# Message to confirm completion
echo "The script $filename$extension has been generated, made executable, and copied to the clipboard."
