# trace generated using paraview version 5.12.0
# import paraview
# paraview.compatibility.major = 5
# paraview.compatibility.minor = 12

#### import the simple module from the paraview
from paraview.simple import *

#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

# get active source.
case_1foam = GetActiveSource()

# Properties modified on case_1foam
case_1foam.CaseType = "Decomposed Case"

# get active view
renderView1 = GetActiveViewOrCreate("RenderView")

# show data in view
case_1foamDisplay = Show(case_1foam, renderView1, "UnstructuredGridRepresentation")

# trace defaults for the display properties.
case_1foamDisplay.Representation = "Surface"

# reset view to fit data
renderView1.ResetCamera(False, 0.9)

# get the material library
materialLibrary1 = GetMaterialLibrary()

# show color bar/color legend
case_1foamDisplay.SetScalarBarVisibility(renderView1, True)

# get color transfer function/color map for 'p'
pLUT = GetColorTransferFunction("p")

# get opacity transfer function/opacity map for 'p'
pPWF = GetOpacityTransferFunction("p")

# get 2D transfer function for 'p'
pTF2D = GetTransferFunction2D("p")

# get animation scene
animationScene1 = GetAnimationScene()

# update animation scene based on data timesteps
animationScene1.UpdateAnimationUsingDataTimeSteps()

# create a new 'Plot Over Line'
plotOverLine1 = PlotOverLine(registrationName="PlotOverLine1", Input=case_1foam)

# Properties modified on case_1foam
case_1foam.MeshRegions = ["internalMesh"]
case_1foam.CellArrays = ["U", "p"]

# Properties modified on plotOverLine1
plotOverLine1.Point1 = [0.0, 0.0, 0.0]
plotOverLine1.Point2 = [0.0, 0.0, 0.4000000059604645]

# show data in view
plotOverLine1Display = Show(plotOverLine1, renderView1, "GeometryRepresentation")

# trace defaults for the display properties.
plotOverLine1Display.Representation = "Surface"

# Create a new 'Line Chart View'
lineChartView1 = CreateView("XYChartView")

# show data in view
plotOverLine1Display_1 = Show(plotOverLine1, lineChartView1, "XYChartRepresentation")

# get layout
layout1 = GetLayoutByName("Layout #1")

# add view to a layout so it's visible in UI
AssignViewToLayout(view=lineChartView1, layout=layout1, hint=0)

# Properties modified on plotOverLine1Display_1
plotOverLine1Display_1.SeriesOpacity = [
    "arc_length",
    "1",
    "p",
    "1",
    "U_X",
    "1",
    "U_Y",
    "1",
    "U_Z",
    "1",
    "U_Magnitude",
    "1",
    "vtkValidPointMask",
    "1",
    "Points_X",
    "1",
    "Points_Y",
    "1",
    "Points_Z",
    "1",
    "Points_Magnitude",
    "1",
]
plotOverLine1Display_1.SeriesPlotCorner = [
    "Points_Magnitude",
    "0",
    "Points_X",
    "0",
    "Points_Y",
    "0",
    "Points_Z",
    "0",
    "U_Magnitude",
    "0",
    "U_X",
    "0",
    "U_Y",
    "0",
    "U_Z",
    "0",
    "arc_length",
    "0",
    "p",
    "0",
    "vtkValidPointMask",
    "0",
]
plotOverLine1Display_1.SeriesLineStyle = [
    "Points_Magnitude",
    "1",
    "Points_X",
    "1",
    "Points_Y",
    "1",
    "Points_Z",
    "1",
    "U_Magnitude",
    "1",
    "U_X",
    "1",
    "U_Y",
    "1",
    "U_Z",
    "1",
    "arc_length",
    "1",
    "p",
    "1",
    "vtkValidPointMask",
    "1",
]
plotOverLine1Display_1.SeriesLineThickness = [
    "Points_Magnitude",
    "2",
    "Points_X",
    "2",
    "Points_Y",
    "2",
    "Points_Z",
    "2",
    "U_Magnitude",
    "2",
    "U_X",
    "2",
    "U_Y",
    "2",
    "U_Z",
    "2",
    "arc_length",
    "2",
    "p",
    "2",
    "vtkValidPointMask",
    "2",
]
plotOverLine1Display_1.SeriesMarkerStyle = [
    "Points_Magnitude",
    "0",
    "Points_X",
    "0",
    "Points_Y",
    "0",
    "Points_Z",
    "0",
    "U_Magnitude",
    "0",
    "U_X",
    "0",
    "U_Y",
    "0",
    "U_Z",
    "0",
    "arc_length",
    "0",
    "p",
    "0",
    "vtkValidPointMask",
    "0",
]
plotOverLine1Display_1.SeriesMarkerSize = [
    "Points_Magnitude",
    "4",
    "Points_X",
    "4",
    "Points_Y",
    "4",
    "Points_Z",
    "4",
    "U_Magnitude",
    "4",
    "U_X",
    "4",
    "U_Y",
    "4",
    "U_Z",
    "4",
    "arc_length",
    "4",
    "p",
    "4",
    "vtkValidPointMask",
    "4",
]

# Properties modified on plotOverLine1Display_1
plotOverLine1Display_1.SeriesVisibility = ["p"]

animationScene1.GoToLast()

# create a new 'Pass Arrays'
passArrays1 = PassArrays(registrationName="PassArrays1", Input=plotOverLine1)

# Properties modified on passArrays1
passArrays1.PointDataArrays = ["arc_length", "p"]

# save data
SaveData(
    "/home/miguel/Desktop/OpenFOAM_Proyects/cerna_permeability/Case_1/deltap.csv",
    proxy=passArrays1,
    ChooseArraysToWrite=1,
    PointDataArrays=["arc_length", "p"],
    AddMetaData=0,
)

# ================================================================
# addendum: following script captures some of the application
# state to faithfully reproduce the visualization during playback
# ================================================================

# --------------------------------
# saving layout sizes for layouts

# layout/tab size in pixels
layout1.SetSize(628, 814)

# -----------------------------------
# saving camera placements for views

# current camera placement for renderView1
renderView1.CameraPosition = [0.0, 0.0, 1.0291222952696286]
renderView1.CameraFocalPoint = [0.0, 0.0, 0.20000000298023224]
renderView1.CameraParallelScale = 0.21459263996355465


##--------------------------------------------
## You may need to add some code at the end of this python script depending on your usage, eg:
#
## Render all views to see them appears
# RenderAllViews()
#
## Interact with the view, usefull when running from pvpython
# Interact()
#
## Save a screenshot of the active view
# SaveScreenshot("path/to/screenshot.png")
#
## Save a screenshot of a layout (multiple splitted view)
# SaveScreenshot("path/to/screenshot.png", GetLayout())
#
## Save all "Extractors" from the pipeline browser
# SaveExtracts()
#
## Save a animation of the current active view
# SaveAnimation()
#
## Please refer to the documentation of paraview.simple
## https://kitware.github.io/paraview-docs/latest/python/paraview.simple.html
##--------------------------------------------

