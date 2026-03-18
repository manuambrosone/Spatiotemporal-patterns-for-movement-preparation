# Spatiotemporal-patterns-for-movement-preparation

**Author:** Manuel Ambrosone

## Overview

This repository contains a MATLAB Live Script that demonstrates an end-to-end pipeline to:

* Visualize mouse behaviour from video recordings
* Compute motion energy from DeepLabCut (DLC) tracking
* Analyze cortical activity using dF/F imaging
* Extract and visualize cortical motifs
* Quantify the relationship between brain dynamics and movement

The pipeline is designed as an **interactive demo** for exploration and visualization.

---

## How to Run

1. **Download the entire repository folder**
2. Open MATLAB
3. Navigate to the downloaded folder
4. Open the Live Script:

```matlab
DEMO.mlx
```

5. Run the script **section by section** (Ctrl + Enter)

---

## Required Files

Make sure these files are in the same folder:

* `Mouse_video.mp4` → behavioural video
* `DLC_file.csv` → DeepLabCut tracking output
* `dff.mat` → cortical imaging data (dF/F)
* `motifs.mat` → motifs decomposition (w, H, nanpxs)

---

## Variables Description

### Input Data

* **videoPath**
  Path to the behavioural video.

* **csvFile**
  DeepLabCut output file containing tracked body parts.

* **dff**
  3D matrix *(X × Y × T)* representing cortical activity over time.

* **w**
  Spatial components of motifs (from CNMF decomposition).

* **H**
  Temporal weights associated with each motif.

* **nanpxs**
  Mask used to reconstruct cortical images.

---

### Parameters

* **fps**
  Frame rate used for visualization.

* **frameRange**
  Subset of frames used in the demo.

* **selectedROIs**
  List of body parts used to compute behavioural motion energy:

  * Eye
  * Snout
  * Whisker
  * Right Forepaw
  * Left Forepaw

* **selected_motifs**
  Subset of motifs used for visualization and analysis.

---

### Computed Variables

* **motionEnergy_behavior**
  Motion energy computed independently for each ROI.

* **motionEnergy_tot**
  Global behavioural motion energy (sum across ROIs).

* **motionEnergy_cortex**
  Cortical motion energy computed as frame-to-frame changes in dF/F.

* **motifs**
  Reconstructed spatiotemporal activity patterns for each motif.

* **cross_corr_matrix**
  Cross-correlation between motif activity and behaviour across time lags.

---

## What the Script Shows

### 1. Schematic Overview

* Mouse reference frame
* dF/F reference frame
* ROI legend

### 2. Behaviour Analysis

* Motion energy per body part
* Global movement dynamics

### 3. Cortex Dynamics

* dF/F signal
* Cortical motion energy
* Frame-by-frame evolution

### 4. Interactive Visualization

* Synchronized:

  * Mouse video
  * dF/F video
  * Behaviour trace
  * Cortical trace

### 5. Motif Analysis

* Example motifs (spatiotemporal patterns)
* Motion energy per motif
* Comparison with behaviour

### 6. Correlation Analysis

* Cross-correlation between motifs and movement
* Identification of motifs preceding behaviour

---

## Notes

* All signals are **normalized** for visualization.
* Motion energy is computed as **frame-to-frame squared difference**.
* Negative lags in correlation indicate **cortical activity preceding movement**.

---

## Requirements

* MATLAB (tested with recent versions)
* Image Processing Toolbox (for `imshow`, `montage`)
* Custom functions:

  * `CalculateMotionEnergyBehaviour`
  * `conditionDffMat`
  * `tensor_convolve`

---

## Goal

This demo provides a compact and intuitive way to link:

**Brain dynamics → Motifs → Behaviour**

---

## Contact

For questions or collaborations, feel free to reach out.
