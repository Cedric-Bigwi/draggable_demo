# Drag to Cart - Flutter Draggable Demo

**Draggable** is a Flutter widget that lets the user pick up a widget and drop it onto a `DragTarget`, carrying data with it.

## What the app does

A small grocery shop. You drag a product (Cookie, Coffee, Cake) into the cart, and the cart shows the item count and total price.

## The three attributes

### 1. `childWhenDragging`
- **Default:** `null` (the original card stays fully visible while dragging)
- **What it changes on screen:** the card left on the shelf fades to 25% opacity during a drag

### 2. `feedback`
- **Default:** none, it is a required property
- **What it changes on screen:** the card that follows the finger (amber color, bigger shadow)

### 3. `axis`
- **Default:** `null` (free movement in any direction)
- **What it changes on screen:** with `Axis.vertical`, the card only moves up and down

## Sources

- Flutter API docs, Draggable class: https://api.flutter.dev/flutter/widgets/Draggable-class.html

## Presentation date

October 12, 2026
