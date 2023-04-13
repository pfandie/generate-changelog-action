#!/bin/bash

set -e

# Check if required NEXT_TAG input is set
if [[ -n "$INPUT_NEXT_TAG" ]]; then
  echo "ℹ️ Set next Tag to $INPUT_NEXT_TAG"
  next_tag="--next-tag '$INPUT_NEXT_TAG'"
fi

# Set Output file
if [[ "$INPUT_WRITE_FILE" == 'true' && -n "$INPUT_OUTPUT_FILE" ]]; then
  echo "ℹ️ Set file output to: $INPUT_OUTPUT_FILE"
  output_file="--output '$INPUT_OUTPUT_FILE'"
fi

# Add Workspace to safe.directory to allow fetching git tags
git config --global --add safe.directory "${GITHUB_WORKSPACE}"

# Generate CHANGELOG based on settings
echo "🔖 Generating CHANGELOG"
changelog=$(/usr/local/bin/git-chglog -c "${INPUT_CONFIG_PATH}/config.yml" "$next_tag" "$output_file")

# Print CHANGELOG to stdout
echo "----------------------------------------------------------"
echo "${changelog}"
echo "----------------------------------------------------------"

# Set output for followup GitHub steps
echo "ℹ️ Return CHANGELOG to Output for use in followup Steps"
{
  echo "changelog<<EOF"
  echo "$changelog"
  echo "EOF"
}  >> "$GITHUB_OUTPUT"
