#!/bin/bash

# Define the available items and their prices
declare -A items=(
    ["Coke"]=1.25
    ["Chips"]=0.75
    ["Chocolate"]=1.50
)

# Function to display the available items and their prices
display_items() {
    echo "Available items:"
    for item in "${!items[@]}"; do
        price=${items[$item]}
        echo "- $item: $price"
    done
}

# Function to process the user's selection
process_selection() {
    selected_item=$1
    selected_price=${items[$selected_item]}

    if [[ -z $selected_price ]]; then
        echo "Invalid item. Please try again."
    else
        echo "You selected $selected_item for $selected_price."
        echo "Please insert the payment."

        read -p "Enter payment amount: " payment
        if (( $(bc <<< "$payment >= $selected_price") )); then
            change=$(bc <<< "$payment - $selected_price")
            echo "Thank you for your purchase! Your change is $change."
        else
            echo "Insufficient payment. Please try again."
        fi
    fi
}

# Main program

echo "Welcome to the Vending Machine!"
echo "==============================="

display_items

read -p "Enter the item you want to purchase: " selected_item
process_selection "$selected_item"
