#!/usr/bin/env bash

EXIT_CODE=0
FAILED_FILES=()

# Loop over all the positional parameters passed to this script. These will
# be a set of files pre-commit believes have changed.
for FILE; do

    # If the first line doesn't begin with the ansible vault content, its an
    # error.  Add the file to the list.
    read -r FIRSTLINE < ${FILE}
    if [[ $FIRSTLINE != '$ANSIBLE_VAULT'* ]]; then
        EXIT_CODE=1
        FAILED_FILES=(${FAILED_FILES[@]} ${FILE} )
    fi
done;

# If there was an error, print an explanation
if [ $EXIT_CODE -ne 0 ]; then
    echo "# COMMIT REJECTED"
    echo "# Plaintext Ansible Vault files detected"
    echo "#"
    for FILE in "${FAILED_FILES[@]}"; do
        echo -e "#\tunencrypted:\t${FILE}"
    done
fi

# Exit with the appropriate error code
exit $EXIT_CODE
