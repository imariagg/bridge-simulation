
# 2D Bridge Simulation

This project consists of the simulation of a 2D truss structure using MATLAB. The code calculates the displacements of the structure's nodes under applied point forces and visualizes both the deformed and undeformed structures.

## Contents

1. `SolverBeam2D.m`: Main script that solves the system of equations for a 2D truss structure.

2. **Problem Description**:  
   The model simulates a bridge composed of multiple steel bars, each with different cross-sectional areas and elastic limits. The forces applied to the nodes cause displacements that are calculated and visualized through graphs.

3. **Results**:
   - The node that experiences the greatest displacement is calculated.
   - The deformed structure is displayed over the undeformed structure.
   - In this case, the node with the largest displacement is node 9, with a displacement of 0.2403 units.

## Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/imariagg/bridge-simulation.git
   ```

2. Ensure MATLAB is installed on your system.

3. Run the `SolverBeam2D.m` script in MATLAB:
   ```matlab
   run('SolverBeam2D.m')
   ```

4. The graphical results will display the deformed structure and the displacement of the most displaced node.

## Requirements

- MATLAB R2022 or higher.
- Graphing libraries for MATLAB (included by default).

## Author

This project was developed by **María García Gómez**, based on the simulation of 2D truss structures.

## License

This project is licensed under the [MIT License](LICENSE).
