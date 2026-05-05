# MFI Cutoff Assistant

This web app provides both a browser interface and a web service to calculate an MFI (Mean Fluorescence Intensity) cutoff for single-antigen bead (SAB) panels. It does this by sorting the panel MFI values, testing every possible split into lower and upper groups, and selecting the split with the lowest combined variance (the sum of squared distances from each group's mean). This approach is used to produce a data-driven cutoff, because lower variance indicates tighter clustering within each group and therefore a more consistent, objective separation between low- and high-reactivity values.

## Support

You can contact me at mariomarroquim@gmail.com.