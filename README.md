# Load Flow Solution
This repository provides the implementation of two techniques for solving power system load flow problem.

1. Gauss-Seidel method - Considering slack and PQ buses only

2. Newton Raphson method - Considering slack, PQ and PV buses

# Getting started
Prepare the impedance data and bus data as follows:

1. Impedance data - 'zbus.dat'

Column 1 - Bus i

Column 2 - Bus j

Column 3 - Line resistance between bus i and bus j

Column 4 - Line reactance between bus i and bus j

Column 5 - Shunt admittance between bus i and bus j

2. Bus data - 'busdata.dat'

Column 1 - Bus i

Column 2 - Active power demand at bus i

Column 3 - Reactive power demand at bus i

Column 4 - Active power generated at bus i

Column 5 - Reactive power generated at bus i

Column 6 - Initial voltage at bus i (assumed)

Note - Bus 1 is assumed to be slack bus.

# Solving the load flow problem
Run either 'GaussSeidel.m' or 'NewtonRaphson.m' depending upon your choice and the type of problem you intend to solve.  
