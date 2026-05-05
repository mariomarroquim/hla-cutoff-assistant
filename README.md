# HLA Cutoff Assistant

This web app provides both a browser interface and a web service for calculating an MFI (Mean Fluorescence Intensity) cutoff value on single-antigen bead panels. It sorts the submitted MFI values, tests every possible split into lower and upper groups, and selects the split with the lowest combined variance (the sum of squared distances from each group's mean). That yields a data-driven cutoff: lower variance reflects tighter clustering within each group and a more consistent separation between low- and high-reactivity beads. The output is an MFI cutoff intended to separate beads interpreted as negative from those that may be positive.

## Support

You can contact me at mariomarroquim@gmail.com.