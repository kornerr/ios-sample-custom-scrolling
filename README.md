
# Overview

`CustomScrolling` is a sample iOS application to implement two manual scrolling layouts.
Each layout expands `currently centered` item and keeps all others collapsed.

The first layout only resizes views.

The second layout also makes sure `currently centered` item is always at the center.

# Preview

Here's how the application looks like:

![Preview][preview]

# XIB structure

![XIB structure][xib-structure]

SampleView contains two prominent UIViews:

* ItemsView
    * is parent to generated views representing items
* GestureView
    * gets UIPanGestureRecognizer at the start
    * is located closer to the user than ItemsView to intercept all gestures

[preview]: readme/preview.gif
[xib-structure]: readme/xib-structure.png
