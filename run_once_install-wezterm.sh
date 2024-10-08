#!/bin/bash

if ! command -v nala &> /dev/null; then
    sudo apt install -y nala
fi

sudo nala update && sudo nala install -y curl

curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

sudo nala update && sudo nala install -y wezterm
