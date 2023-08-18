# MF5.2 Based YMD Tool
Fit Calspan TIRF tire data to the MF5.2 Magic Tyre Model and create Yawing Moment diagrams for your racecar
### Data pre-processing and fitting
1. Load any of the provided raw test data .m files into your workspace
2. Run "MF52_data_preprocessing.m"
3. Select a portion of the plot consisting of 3 Inclination Angles. Be sure to check that you cover a total of 15 normal load sweeps in those 3 IA sweeps, 5 normal load sweeps for each IA sweep
4. Let go of the mouse click and save the workspace
5. Run the "MF52_fitter_fy.m"
6. Wait while the coefficients of the model iteratively adjust, uptil 60 iterations
7. Save the workspace

### Plotting the Yaw-Moment Diagram
1. Open the file "bicycle_model.m" in your editor
2. Adjust your racecar parameters such as total mass, front-rear mass distribution, roll centre heights, suspension stiffnesses, wheelbase, track lengths, static toe and camber etc.
3. The file "roll_camber" contains a data fitted equation for the camber angle of the wheels as a function of chassis roll. This is easy to create if you know your suspension geometry and have it modelled in a tool like "Lotus Shark Suspension Anaylsis".
4. Load the tire data fitting workspace
5. Run "bicycle_model.m"
6. Finally run "YMD_plotter_test.m"
7. Observe and analyse your Yawing Moment Diagram
