#############################################################################
# JuMP
# An algebraic modelling langauge for Julia
# See http://github.com/JuliaOpt/JuMP.jl
#############################################################################
# simplelazy2.jl
#
# Builds on the simplelazy example by demonstrating how the logic of
# determing a new constraint can be seperated from the logic of the callback
# handler itself.
#############################################################################

using JuMP
using Gurobi
using Base.Test

function cornerChecker(x_val, y_val)
    # This function does not depend on the model, and could
    # be written anywhere. Instead, it returns a tuple of
    # values (newcut, x_coeff, y_coeff, rhs) where newcut is a
    # boolean if a cut is needed, x_coeff is the coefficient
    # on the x variable, y_coeff is the coefficient on
    # the y variable, and rhs is the right hand side
    TOL = 1e-6
    if y_val - x_val > 1 + TOL
        return (true, -1.0, 1.0, 1.0)  # Top left
    elseif y_val + x_val > 3 + TOL
        return (true,  1.0, 1.0, 3.0)  # Top right
    else
        return (false, 0.0, 0.0, 0.0)  # No cut
    end
end

# A unit test for the cornerChecker function
function test_cornerChecker()
    # Test the four corners - only two should produce cuts
    newcut, x_coeff, y_coeff, rhs = cornerChecker(0, 0)
    @test !newcut

    newcut, x_coeff, y_coeff, rhs = cornerChecker(2, 0)
    @test !newcut

    newcut, x_coeff, y_coeff, rhs = cornerChecker(0, 2)
    @test newcut
    @test x_coeff == -1.0
    @test y_coeff ==  1.0
    @test rhs == 1.0

    newcut, x_coeff, y_coeff, rhs = cornerChecker(2, 2)
    @test newcut
    @test x_coeff ==  1.0
    @test y_coeff ==  1.0
    @test rhs == 3.0
end

function solveProblem()
    m = Model(solver=GurobiSolver())

    @defVar(m, 0 <= x <= 2, Int)
    @defVar(m, 0 <= y <= 2, Int)
    @setObjective(m, Max, y)

    # Note that the callback is now a stub that passes off
    # the work to the "algorithm"
    function corners(cb)
        x_val = getValue(x)
        y_val = getValue(y)
        println("In callback function, x=$x_val, y=$y_val")

        newcut, x_coeff, y_coeff, rhs = cornerChecker(x_val, y_val)

        if newcut
            @addLazyConstraint(cb, x_coeff*x + y_coeff*y <= rhs)
        end
    end  # End of callback function

    addLazyCallback(m, corners)
    solve(m)
    println("Final solution: [ $(getValue(x)), $(getValue(y)) ]")
end

# Run tests
test_cornerChecker()

# Solve it
solveProblem()
